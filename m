Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVCWQpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVCWQpm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 11:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVCWQoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 11:44:00 -0500
Received: from web52204.mail.yahoo.com ([206.190.39.86]:21355 "HELO
	web52204.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262729AbVCWQl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 11:41:29 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=RlGw2bIXfQFiNMEw53lbZectamab43K+Rsu8TBFcLS9w/AVO5ESQV+omt8zTA1pB7SW3shcfvk/5So+/921bhot4QzBrJP1oCZA1onQx8IT43eH2w9aUvbAzS9ufG91uAB1L24syqvHXAbF5COdwdMDumOh3JNzVDwuIjfrc1hg=  ;
Message-ID: <20050323164129.70589.qmail@web52204.mail.yahoo.com>
Date: Wed, 23 Mar 2005 08:41:29 -0800 (PST)
From: linux lover <linux_lover2004@yahoo.com>
Subject: Re: Accessing data structure from kernel space
To: linux-os@analogic.com, linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-os,
--- linux-os <linux-os@analogic.com> wrote:
> On Wed, 23 Mar 2005, linux lover wrote:
> 
> > Hello all,
> >        I have one linked list data structure added
> to
> > a file in kernel source code which has some kernel
> > info. I want to acess that linked list structure
> from
> > user space. Is that possible??
> >        Also how to add own system call usable at
> user
> > level from kernel module??
> > regards,
> > linux_lover.
> >
> 
> Many people will tell you to use the /proc
> file-system.
> I suggest you make a simple "character" driver and
> access
> your kernel structure using ioctl() or mmap().
> 
      How can i access that linked list structure in
kernel at user space say if i write character driver
as /dev/readll then how to link that structure to
device driver
? 
> You don't add your own system call __ever__, even if
> you
> are a long-time kernel developer. The current API
> already
> has lots of standard interface capabilities.
> Thinking, even
> for an instant, that you need more means that you
> don't
> understand Unix/Linux.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.11 on an i686 machine
> (5537.79 BogoMips).
>   Notice : All mail here is now cached for review by
> Dictator Bush.
>                   98.36% of all statistics are
> fiction.
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
