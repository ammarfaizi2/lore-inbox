Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbRDFLip>; Fri, 6 Apr 2001 07:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131484AbRDFLif>; Fri, 6 Apr 2001 07:38:35 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:8715 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S131481AbRDFLiU>; Fri, 6 Apr 2001 07:38:20 -0400
Date: Fri, 6 Apr 2001 04:36:52 -0700 (PDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: Andreas Dilger <adilger@turbolinux.com>, Andrew Daviel <advax@triumf.ca>,
        <linux-kernel@vger.kernel.org>
Subject: Re: syslog insmod please!
In-Reply-To: <Pine.LNX.4.30.0104052147060.14947-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.32.0104060429500.17426-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Ion ,

On Thu, 5 Apr 2001, Ion Badulescu wrote:
> On Thu, 5 Apr 2001, Andreas Dilger wrote:
> > Why do it from user space?  Simply add a printk() to sys_init_module() or
> > similar.
> Agreed, but at that point the solution has absolutely nothing to do with
> insmod anymore. :-)

> Besides, as you said, I don't really see the point. It certainly doesn't
> help with logging the actions of an attacker, and on the other hand kmod
> already logs its own actions.
	Not the problem being discussed ,  This is a user now root &
	having gained root is now attempting to from the command line
	to load a module .  How do we get this event recorded ?  kmod
	only works when the user calles for the service & then it loads
	it .  Tia ,  JimL
       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

