Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279591AbRKVOBs>; Thu, 22 Nov 2001 09:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279603AbRKVOBi>; Thu, 22 Nov 2001 09:01:38 -0500
Received: from [212.169.100.200] ([212.169.100.200]:30191 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S279591AbRKVOBf>; Thu, 22 Nov 2001 09:01:35 -0500
Date: Thu, 22 Nov 2001 15:07:38 +0100
From: Morten Helgesen <admin@nextframe.net>
To: linux-kernel@vger.kernel.org
Subject: Re:  [PATCH] remove last references to linux/malloc.h
Message-ID: <20011122150738.D117@sexything>
Reply-To: admin@nextframe.net
In-Reply-To: <20011122145527.A117@sexything> <27400.1006437269@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27400.1006437269@redhat.com>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey David.

I see your point - but someone has obiously decided to switch from malloc.h to slab.h, and I do not
see the point in having three references to malloc.h when malloc.h only prints a warning and then includes
slab.h

== Morten


On Thu, Nov 22, 2001 at 01:54:29PM +0000, David Woodhouse wrote:
> 
> 
> admin@nextframe.net said:
> >  Ok people - stop submitting patches which include malloc.h. Include
> > slab.h instead. :)
> 
> Bah. I was sort of hoping we'd come to our collective senses and switch 
> them all back.
> 
> What does malloc.h do? Stuff to do with memory allocation, one presumes.
> What does slab.h do? Some random implementation detail that people have no 
> business knowing about.
> 
> --
> dwmw2
> 
> 

-- 
mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
