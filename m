Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263707AbTIHVGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 17:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263716AbTIHVGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 17:06:04 -0400
Received: from srahubgw.sra.com ([163.252.31.6]:60933 "EHLO srahubgw.sra.com")
	by vger.kernel.org with ESMTP id S263707AbTIHVGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 17:06:01 -0400
Message-ID: <16220.61238.347537.307965@irving.iisd.sra.com>
From: David Garfield <garfield@irving.iisd.sra.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org, andersen@codepoet.org,
       Matthew Wilcox <willy@debian.org>
Date: Mon, 8 Sep 2003 17:05:58 -0400
Subject: Re: kernel header separation
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: VM 6.96 under Emacs 20.7.1
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk>
	<20030903014908.GB1601@codepoet.org>
	<20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk>
	<20030905211604.GB16993@codepoet.org>
	<16220.58678.399619.878405@irving.iisd.sra.com>
	<20030908223409.B1085@pclin040.win.tue.nl>
In-Reply-To: <20030908223409.B1085@pclin040.win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer writes:
 > On Mon, Sep 08, 2003 at 04:23:18PM -0400, David Garfield wrote:
 > 
 > > On the other hand, the ISO C99 definition is probably something like:
 > > an integral type capable of storing the values 0 through 255
 > > inclusive.  (ok, I don't have a copy of the new standard but I have
 > > seriously examined the old one.)  I would not count on uint8_t
 > > necessarily being unsigned on unusual hardware.
 > 
 > Why do you come with FUD and speculation when it is so easy
 > to check the facts?
 > 
 >   "The typedef name intN_t designates a signed integer type with width N,
 >    no padding bits, and a two's complement representation. Thus, int8_t
 >    denotes a signed integer type with a width of exactly 8 bits.
 > 
 >    The typedef name uintN_t designates an unsigned integer type with width N.
 >    Thus, uint24_t denotes an unsigned integer type with a width of exactly 24 bits.
 > 
 >    These types are optional. However, if an implementation provides integer types with
 >    widths of 8, 16, 32, or 64 bits, it shall define the corresponding typedef names."

1) It was not my intent to produce FUD, and speculation is because I
   understood this was not a freely available standard (it can be
   found at http://anubis.dkuug.dk/JTC1/SC22/WG14/www/standards ).

2) I have now downloaded and read some of this standard.  You do
   realize that a uint16_t can take 32 bits, don't you?  (Hint: reread
   section 6.2.6.2 for the definition of width.)

3) There is still the issue that these types are not guaranteed to
   exist, as you have quoted.  Also the issue that what Linux
   guarantees for these types is not specified.

--David Garfield

