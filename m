Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289316AbSAIKAp>; Wed, 9 Jan 2002 05:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289318AbSAIKAd>; Wed, 9 Jan 2002 05:00:33 -0500
Received: from codepoet.org ([166.70.14.212]:33036 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S289316AbSAIKAO>;
	Wed, 9 Jan 2002 05:00:14 -0500
Date: Wed, 9 Jan 2002 03:00:13 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109100013.GB8743@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020108192450.GA14734@kroah.com> <20020109042331.GB31644@codeblau.de> <20020109043446.GB17655@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109043446.GB17655@kroah.com>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jan 08, 2002 at 08:34:47PM -0800, Greg KH wrote:
> On Wed, Jan 09, 2002 at 05:23:31AM +0100, Felix von Leitner wrote:
> > 
> > How many programs are we talking about here?  And what should they do?
> 
> Very good question that we should probably answer first (I'll follow up
> to your other points in a separate message).
> 
> Here's what I want to have in my initramfs:
> 	- /sbin/hotplug
> 	- /sbin/modprobe
> 	- modules.dep (needed for modprobe, but is a text file)
> 
> What does everyone else need/want there?

I think you want a staticly linked multi-call binary, a 
trivial shell, and some kernel modules...
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0112.2/0681.html

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
