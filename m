Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbTEAOl7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbTEAOl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:41:58 -0400
Received: from h-66-134-11-58.CHCGILGM.covad.net ([66.134.11.58]:54800 "EHLO
	miniborg.vocalabs.com") by vger.kernel.org with ESMTP
	id S261324AbTEAOl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:41:58 -0400
Date: Thu, 1 May 2003 05:53:53 -0400 (EDT)
From: Daniel Taylor <dtaylor@vocalabs.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Boot failure, VIA chipset.
In-Reply-To: <20030430214848.GB24111@suse.de>
Message-ID: <Pine.LNX.4.44.0305010547210.1739-100000@dante.vocalabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003, Dave Jones wrote:

> On Wed, Apr 30, 2003 at 11:11:54AM -0500, Daniel Taylor wrote:
>  > I have a KT400-based system that will not boot the 2.5 series kernels.
>  >
>  > It fails with a hard lock immediately after the video mode query when
>  > VGA=ask is set in /etc/lilo.conf.
>  >
>  > If anyone else is working on this contact me, otherwise I'll post
>  > my results when I get it working.
>
> make sure you enabled
>
> CONFIG_INPUT=y
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
>
All enabled, and I tried last night with a stripped down 386 only kernel.

No dice, dies hard even before printing the Kernel ID.

It is probably a BIOS compatability issue, but it works OK with 2.4. Since
the system actually works as it sits I've been taking my time debugging
the 2.5 issues.

-- 
Daniel Taylor        VP Operations and Development   Vocal Laboratories, Inc.
dtaylor@vocalabs.com   http://www.vocalabs.com/        (952)941-6580x203

