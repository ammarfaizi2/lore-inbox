Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132747AbRDQQYM>; Tue, 17 Apr 2001 12:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132743AbRDQQYC>; Tue, 17 Apr 2001 12:24:02 -0400
Received: from c265749-c.crvlls1.or.home.com ([65.0.120.252]:32772 "EHLO
	c1033624-a.crvlls1.or.home.com") by vger.kernel.org with ESMTP
	id <S132744AbRDQQXx>; Tue, 17 Apr 2001 12:23:53 -0400
Date: Tue, 17 Apr 2001 09:24:28 -0700
From: coop@axian.com
To: linux-kernel@vger.kernel.org
Cc: coop@axian.com
Subject: Re: Documentation of module parameters.
Message-ID: <20010417092428.A2650@p3.coop.hom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can use the "modinfo" utility (Do "man modinfo".)  In particular

  modinfo -p driver.o

will give any parameters that can be set in driver.o.  If the module
author has used the MODULE_PARM_DESC() macro, more documentation
can be found.

======================================================================
 Jerry Cooperstein, PhD        <coop@axian.com>
 Senior Consultant
                                            ____       _
 Axian, Inc.   <info@axian.com>              // |_  __(_) ___  _ __
 4800 SW Griffith Dr., Ste. 202             //| |\\/ /| |/ _ \| '_ \
 Beaverton, OR  97005 USA             _____//_| | / / | | |_| | | | |
 Voice: (541)758-8020                ((   //  |_|/_/\\|_|\_/|_|_| |_|
                                      ``-''          ``-''
 http://www.axian.com/               Software Consulting and Training
======================================================================



>I was recently looking for a single location where all the possible 
>module parameters for the linux kernel was located. 
>
>I figured I would look at the source first, hoping that each module 
>maintaier would clearly document at the beginning of each .c file all of 
>the parameters his or her module can accept. Sadly, that's not always 
>the case. Some modules are well documented, others are a complete 
>mystery. If I was a programmer myself, I might be able to determine from 
>the code itself what parameters are possible, but that's not one of my 
>talents. Could any and all of you please take the time to document your 
>code, and keep the comments up to date when it changes? I think that in 
>the source code itself is the best place for such documentation, as you 
>have the chance to fix the docs with every patch, and the source is 
>always included in each distribution. Then from the source can any 
>exterior documentation be gleaned. Those of us who don't speak C would 
>really appreciate it. 

>Thanks In Advance. 

>Chris Kloiber 
