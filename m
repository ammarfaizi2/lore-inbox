Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWBCK1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWBCK1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBCK1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:27:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9742 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751036AbWBCK1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:27:31 -0500
Date: Fri, 3 Feb 2006 10:27:21 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Akinobu Mita'" <mita@miraclelinux.com>,
       Grant Grundler <iod00d@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 1/12] generic *_bit()
Message-ID: <20060203102721.GE30738@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Christoph Hellwig' <hch@infradead.org>,
	'Akinobu Mita' <mita@miraclelinux.com>,
	Grant Grundler <iod00d@hp.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linux-ia64@vger.kernel.org
References: <20060201180237.GA18464@infradead.org> <200602011807.k11I7ag15563@unix-os.sc.intel.com> <20060201191957.GG3072@flint.arm.linux.org.uk> <Pine.LNX.4.62.0602031123190.30934@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0602031123190.30934@pademelon.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 11:24:30AM +0100, Geert Uytterhoeven wrote:
> On Wed, 1 Feb 2006, Russell King wrote:
> > Invalid assumption, from the point of view of endianness across different
> > architectures.  Consider where bit 0 is for a LE and BE unsigned long *
> > vs a LE and BE unsigned char *.
> 
> Intel doesn't care about big endian (cfr. your lkml back issues of January
> 2006).

Incorrect.  Intel does actually produce big endian CPUs - most of the
Intel IXP (ARM based) stuff is big endian.  It just depends which part
of Intel you're referring to.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
