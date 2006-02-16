Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWBPLwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWBPLwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 06:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWBPLwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 06:52:12 -0500
Received: from isilmar.linta.de ([213.239.214.66]:41690 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932254AbWBPLwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 06:52:10 -0500
Date: Thu, 16 Feb 2006 12:52:08 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Dave Airlie <airlied@gmail.com>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com,
       dri-devel@lists.sourceforge.net
Subject: Re: IRQ disabled (i915?) when switchig between gnome themes (gnome-theme-manager)
Message-ID: <20060216115208.GA30437@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	davej@redhat.com, dri-devel@lists.sourceforge.net
References: <20060130203809.GA8098@dominikbrodowski.de> <21d7e9970602132255l5a7ff5feqa82ccad2c90ac4d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970602132255l5a7ff5feqa82ccad2c90ac4d8@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 14, 2006 at 05:55:16PM +1100, Dave Airlie wrote:
> Can you try the patch at
> http://www.skynet.ie/~airlied/patches/dri/i915_irq_stop.diff
> 
> I think it might fix it, it cleans up any pending interrupts on disable..

Thanks, this patch solves the issue.

	Dominik
