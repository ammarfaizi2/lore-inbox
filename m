Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291547AbSCOMEG>; Fri, 15 Mar 2002 07:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291620AbSCOMD5>; Fri, 15 Mar 2002 07:03:57 -0500
Received: from ns.ithnet.com ([217.64.64.10]:51463 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S291547AbSCOMDr>;
	Fri, 15 Mar 2002 07:03:47 -0500
Date: Fri, 15 Mar 2002 13:03:38 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org, green@namesys.com,
        trond.myklebust@fys.uio.no
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020315130338.539c1118.skraw@ithnet.com>
In-Reply-To: <6uofhq12rl.fsf@zork.zork.net>
In-Reply-To: <200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<20020311091458.A24600@namesys.com>
	<20020311114654.2901890f.skraw@ithnet.com>
	<20020311135256.A856@namesys.com>
	<20020311155937.A1474@namesys.com>
	<20020315141328.A1879@namesys.com>
	<20020315123008.14237953.skraw@ithnet.com>
	<6uofhq12rl.fsf@zork.zork.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002 11:36:30 +0000
Sean Neakums <sneakums@zork.net> wrote:

> commence  Stephan von Krawczynski quotation:
> 
> > Another point to clarify, my client fstab entry looks like this:
> >
> > 192.168.1.2:/p2/backup  /backup                 nfs     timeo=20,dev,suid,rw,exec,user,rsize=8192,wsize=8192       0 0
> >
> > I cannot say anything about the second fs mounted via YaST.
> 
> Surely running mount from another window/console after starting YaST would
> reveal this information?

Sorry, weekend in sight ;-)

admin:/p2/backup on /backup type nfs (rw,noexec,nosuid,nodev,timeo=20,rsize=8192,wsize=8192,addr=192.168.1.2)
admin:/p3/suse/6.4 on /var/adm/mount type nfs (ro,intr,addr=192.168.1.2)

BTW: another fs mounted from a different server on the same client is not affected at all from this troubles.
Are there any userspace tools with problems involved? mount ? maybe I should replace something ...

Regards,
Stephan

