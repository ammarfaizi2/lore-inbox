Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUCCXqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUCCXqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:46:10 -0500
Received: from gprs40-129.eurotel.cz ([160.218.40.129]:15729 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261269AbUCCXqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:46:06 -0500
Date: Thu, 4 Mar 2004 00:45:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@redhat.com>,
       Cpufreq mailing list <cpufreq@www.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>, paul.devriendt@amd.com
Subject: Re: powernow-k8-acpi driver
Message-ID: <20040303234553.GJ222@elf.ucw.cz>
References: <20040303215435.GA467@elf.ucw.cz> <20040303222712.GA16874@redhat.com> <20040303223510.GE222@elf.ucw.cz> <20040303224841.GB16874@redhat.com> <20040303231143.GH222@elf.ucw.cz> <20040303233939.GB18722@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303233939.GB18722@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > Dave, could you apply these? That are cleanups from Paul's new version
>  > of driver (killed few unused defines, right names for MSR's
>  > (hopefully!), more linux-like comments). No code changes.
> 
> Looks trivial enough. I just bounced it forward to Linus directly.
> (I'm travelling this week, and bitkeeper on a laptop is unfunny)

:-)

>  > - *   (c) 2003 Advanced Micro Devices, Inc.
>  > + *   (c) 2003, 2004 Advanced Micro Devices, Inc.
>  >   *  Your use of this code is subject to the terms and conditions of the
>  > - *  GNU general public license version 2. See "../../../COPYING" or
>  > + *  GNU general public license version 2. See "../../../../../COPYING" or
>  >   *  http://www.gnu.org/licenses/gpl.html
>  >   */
> 
> This bit seems really silly though, but thats just my opinion 8-)
> I'd just kill the ../'s completely.

Agreed, I assume AMD lawyers wanted that... If not, perhaps we can
make it disappear.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
