Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbTIHUgZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTIHUgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:36:25 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:60422 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263623AbTIHUeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:34:12 -0400
Date: Mon, 8 Sep 2003 22:34:09 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: David Garfield <garfield@irving.iisd.sra.com>
Cc: linux-kernel@vger.kernel.org, andersen@codepoet.org,
       Matthew Wilcox <willy@debian.org>
Subject: Re: kernel header separation
Message-ID: <20030908223409.B1085@pclin040.win.tue.nl>
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk> <20030903014908.GB1601@codepoet.org> <20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk> <20030905211604.GB16993@codepoet.org> <16220.58678.399619.878405@irving.iisd.sra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16220.58678.399619.878405@irving.iisd.sra.com>; from garfield@irving.iisd.sra.com on Mon, Sep 08, 2003 at 04:23:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 04:23:18PM -0400, David Garfield wrote:

> On the other hand, the ISO C99 definition is probably something like:
> an integral type capable of storing the values 0 through 255
> inclusive.  (ok, I don't have a copy of the new standard but I have
> seriously examined the old one.)  I would not count on uint8_t
> necessarily being unsigned on unusual hardware.

Why do you come with FUD and speculation when it is so easy
to check the facts?

  "The typedef name intN_t designates a signed integer type with width N,
   no padding bits, and a two's complement representation. Thus, int8_t
   denotes a signed integer type with a width of exactly 8 bits.

   The typedef name uintN_t designates an unsigned integer type with width N.
   Thus, uint24_t denotes an unsigned integer type with a width of exactly 24 bits.

   These types are optional. However, if an implementation provides integer types with
   widths of 8, 16, 32, or 64 bits, it shall define the corresponding typedef names."


