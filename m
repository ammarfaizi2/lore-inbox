Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292458AbSCOOIL>; Fri, 15 Mar 2002 09:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292466AbSCOOIB>; Fri, 15 Mar 2002 09:08:01 -0500
Received: from ns.ithnet.com ([217.64.64.10]:65039 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S292458AbSCOOHz>;
	Fri, 15 Mar 2002 09:07:55 -0500
Date: Fri, 15 Mar 2002 15:07:43 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: sneakums@zork.net, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020315150743.0993af3c.skraw@ithnet.com>
In-Reply-To: <20020315150536.A2279@namesys.com>
In-Reply-To: <200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<20020311091458.A24600@namesys.com>
	<20020311114654.2901890f.skraw@ithnet.com>
	<20020311135256.A856@namesys.com>
	<20020311155937.A1474@namesys.com>
	<20020315150536.A2279@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002 15:05:36 +0300
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Fri, Mar 15, 2002 at 01:03:38PM +0100, Stephan von Krawczynski wrote:
> 
> > Sorry, weekend in sight ;-)
> > admin:/p2/backup on /backup type nfs (rw,noexec,nosuid,nodev,timeo=20,rsize=8192,wsize=8192,addr=192.168.1.2)
> > admin:/p3/suse/6.4 on /var/adm/mount type nfs (ro,intr,addr=192.168.1.2)
> > BTW: another fs mounted from a different server on the same client is not affected at all from this troubles.
> > Are there any userspace tools with problems involved? mount ? maybe I should replace something ...
> 
> Do not know about the tools, can you run reiserfsck on all exported volumes just
> in case?

Runs without problems on both exported filesystems.

Regards,
Stephan
