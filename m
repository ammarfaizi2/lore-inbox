Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291620AbSCOMF4>; Fri, 15 Mar 2002 07:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291753AbSCOMFq>; Fri, 15 Mar 2002 07:05:46 -0500
Received: from angband.namesys.com ([212.16.7.85]:64129 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S291620AbSCOMFh>; Fri, 15 Mar 2002 07:05:37 -0500
Date: Fri, 15 Mar 2002 15:05:36 +0300
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Sean Neakums <sneakums@zork.net>, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-ID: <20020315150536.A2279@namesys.com>
In-Reply-To: <200203110018.BAA11921@webserver.ithnet.com> <15499.64058.442959.241470@charged.uio.no> <20020311091458.A24600@namesys.com> <20020311114654.2901890f.skraw@ithnet.com> <20020311135256.A856@namesys.com> <20020311155937.A1474@namesys.com> <20020315141328.A1879@namesys.com> <20020315123008.14237953.skraw@ithnet.com> <6uofhq12rl.fsf@zork.zork.net> <20020315130338.539c1118.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020315130338.539c1118.skraw@ithnet.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 15, 2002 at 01:03:38PM +0100, Stephan von Krawczynski wrote:

> Sorry, weekend in sight ;-)
> admin:/p2/backup on /backup type nfs (rw,noexec,nosuid,nodev,timeo=20,rsize=8192,wsize=8192,addr=192.168.1.2)
> admin:/p3/suse/6.4 on /var/adm/mount type nfs (ro,intr,addr=192.168.1.2)
> BTW: another fs mounted from a different server on the same client is not affected at all from this troubles.
> Are there any userspace tools with problems involved? mount ? maybe I should replace something ...

Do not know about the tools, can you run reiserfsck on all exported volumes just
in case?

Bye,
    Oleg
