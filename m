Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264089AbTEJM7w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 08:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbTEJM7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 08:59:51 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:59355 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264089AbTEJM7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 08:59:50 -0400
Date: Sat, 10 May 2003 14:12:35 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Improved DRM support for cant_use_aperture platforms
Message-ID: <20030510131235.GB21862@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, davidm@hpl.hp.com,
	linux-kernel@vger.kernel.org
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 03:09:16AM -0700, David Mosberger wrote:
 > Hi Dave,
 > 
 > This patch is rather big, but actually very straight-forward: it adds
 > a "agp dev" argument to DRM_IOREMAP(), DRM_IOREMAP_NOCACHE(), and
 > DRM_IOREMAPFREE() and then uses it in drm_memory.h to support
 > platforms where CPU accesses to the AGP space are not translated by
 > the GART 

That's one to run by the dri-devel@lists.sf.net folks.

		Dave

