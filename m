Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266536AbRGLTVW>; Thu, 12 Jul 2001 15:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266539AbRGLTVM>; Thu, 12 Jul 2001 15:21:12 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:48458 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S266536AbRGLTU5>; Thu, 12 Jul 2001 15:20:57 -0400
Message-ID: <3B4DF785.F0273621@sgi.com>
Date: Thu, 12 Jul 2001 12:16:21 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, Hans Reiser <reiser@namesys.com>,
        reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: Security hooks, "standard linux security" & embedded use
In-Reply-To: <3B49F602.DB39B3A@sgi.com> <3B4DDFD8.27C1C3D9@namesys.com> <5.1.0.14.2.20010712192608.0365e588@pop.cus.cam.ac.uk> <20010712114729.B735@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> The current model lets you do whatever you want in your kernel module.
> It imposes no policy, that's up to you.
---
	That's not exactly true.  It imposes the standard Linux security
policy which someone wanting to remove it or change it might not want.
It only allows you to further restrict based on the current security 
system.  
> 
> All the better to keep userspace callbacks for security out of my
> kernels, for that way is ripe for problems (for specific examples why,
> see the linux-security-module mailing list archives.)
---
	I agree.  Though an individual module writer could theoretically
implement callbacks in their own module, no?

-l

--  -    _    -    _    -    _    -    _    -    _    -    _    -    _    -     
The above thoughts and            | I know I don't know the opinions
writings are my own.              | of every part of my company. :-)
