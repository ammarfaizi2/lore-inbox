Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTD3RTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 13:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbTD3RTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 13:19:37 -0400
Received: from h-66-134-11-58.CHCGILGM.covad.net ([66.134.11.58]:18185 "EHLO
	miniborg.vocalabs.com") by vger.kernel.org with ESMTP
	id S262268AbTD3RTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 13:19:36 -0400
Date: Wed, 30 Apr 2003 11:31:43 -0500 (CDT)
From: Daniel Taylor <dtaylor@vocalabs.com>
To: Balram Adlakha <b_adlakha@softhome.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Boot failure, VIA chipset.
In-Reply-To: <20030430171909.GA9529@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0304301126430.7276-100000@dtaylor.vocalabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003, Balram Adlakha wrote:

> On Wed, Apr 30, 2003 at 11:11:54AM -0500, Daniel Taylor wrote:
> > I have a KT400-based system that will not boot the 2.5 series kernels.
> >
> > It fails with a hard lock immediately after the video mode query when
> > VGA=ask is set in /etc/lilo.conf.
> >
> > If anyone else is working on this contact me, otherwise I'll post
> > my results when I get it working.
> >
>
> And what happens when VGA=ask is not set? What happens when its disabled in the config?
>
It fails silently after unpacking the kernel.

Sorry, I was insufficiently clear on that.

So far I have tried:
  Disabling all module functions
  Disabling APIC
  Recompiling for 386 rather than K7
  Disabling all special video options (Framebuf,  video mode select)

I have yet to try a completely minimal 386 config, that is my next step,
then I start putting printk()'s in to localise the hang more effectively.

-- 
Daniel Taylor        VP Operations and Development   Vocal Laboratories, Inc.
dtaylor@vocalabs.com   http://www.vocalabs.com/        (952)941-6580x203

