Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbUCCXkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUCCXko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:40:44 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:6531 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261263AbUCCXkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:40:35 -0500
Date: Wed, 3 Mar 2004 23:39:39 +0000
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Cpufreq mailing list <cpufreq@www.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>, davej@codemonkey.ork.uk,
       paul.devriendt@amd.com
Subject: Re: powernow-k8-acpi driver
Message-ID: <20040303233939.GB18722@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@suse.cz>,
	Cpufreq mailing list <cpufreq@www.linux.org.uk>,
	kernel list <linux-kernel@vger.kernel.org>, davej@codemonkey.ork.uk,
	paul.devriendt@amd.com
References: <20040303215435.GA467@elf.ucw.cz> <20040303222712.GA16874@redhat.com> <20040303223510.GE222@elf.ucw.cz> <20040303224841.GB16874@redhat.com> <20040303231143.GH222@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303231143.GH222@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 12:11:43AM +0100, Pavel Machek wrote:

 > Dave, could you apply these? That are cleanups from Paul's new version
 > of driver (killed few unused defines, right names for MSR's
 > (hopefully!), more linux-like comments). No code changes.

Looks trivial enough. I just bounced it forward to Linus directly.
(I'm travelling this week, and bitkeeper on a laptop is unfunny)

 > - *   (c) 2003 Advanced Micro Devices, Inc.
 > + *   (c) 2003, 2004 Advanced Micro Devices, Inc.
 >   *  Your use of this code is subject to the terms and conditions of the
 > - *  GNU general public license version 2. See "../../../COPYING" or
 > + *  GNU general public license version 2. See "../../../../../COPYING" or
 >   *  http://www.gnu.org/licenses/gpl.html
 >   */

This bit seems really silly though, but thats just my opinion 8-)
I'd just kill the ../'s completely.

		Dave

