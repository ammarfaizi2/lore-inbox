Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285195AbRLRVgN>; Tue, 18 Dec 2001 16:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285207AbRLRVe3>; Tue, 18 Dec 2001 16:34:29 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:40013 "EHLO
	tsmtp7.mail.isp") by vger.kernel.org with ESMTP id <S285180AbRLRVd3>;
	Tue, 18 Dec 2001 16:33:29 -0500
Date: Tue, 18 Dec 2001 22:35:40 +0100
From: Diego Calleja <grundig@teleline.es>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: Reiserfs corruption on 2.4.17-rc1!
Message-ID: <20011218223540.A377@diego>
In-Reply-To: <20011217025856.A1649@diego> <13425.1008580831@nova.botz.org> <20011218003359.A555@diego> <15391.12150.650359.33792@laputa.namesys.com> <3C1F3FDA.5050601@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3C1F3FDA.5050601@namesys.com>; from reiser@namesys.com on Tue, Dec 18, 2001 at 14:08:42 +0100
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001 14:08:42 Hans Reiser wrote:
> Nikita Danilov wrote:
> 
> >Diego Calleja writes:
> >
> >
> >Unfortunately this looks like "standard" reiserfs tree corruption. 
> >Take
> >
> A little more precisely: nobody at Namesys has ever hit this bug using 
> our known healthy hardware.  Various users have.  Bad hardware (e.g 
> media defect) could cause this bug, and maybe cause it in just about the 
> number of users that we see it in.   This does NOT mean that it is due 
> to bad hardware.  If you, or anyone, can reproduce this bug, we would be 
> very interested to learn how to do so.
> 
> Hans
I'm afraid I can't. It just happened. I only can describe what was I doing,
although it must be useless....
The system booted with linux 2.4.17-rc1. I was readin mail in kde
 when  I tried to mount my vfat partition on /win to listen mp3. (as a
normal
 user, of course). But  I couldn't mount it. Reason?:
 	ls: mtab: permission denied
 Then I log as root, but ls -l /etc/mtab said:
 	ls: mtab: permission denied
 any chmod in /etc/mtab: (as root)
 	chmod: getting attributes of mtab: Permission denied

 After this, the filesystem started to fail a lot in all other programs
 , the problem is in some files in /etc.


