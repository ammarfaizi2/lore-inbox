Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUDNN6i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 09:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUDNN6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 09:58:38 -0400
Received: from ms-smtp-05-smtplb.tampabay.rr.com ([65.32.5.135]:41910 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S263823AbUDNN6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 09:58:37 -0400
Date: Wed, 14 Apr 2004 09:58:33 -0400
From: maccorin@cfl.rr.com
To: linux-kernel@vger.kernel.org
Subject: Re: Using compression before encryption in device-mapper
Message-ID: <20040414135833.GA30062@lappy>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200404131744.40098.Guillaume@Lacote.name> <200404140854.56387.Guillaume@Lacote.name> <20040414094334.GA25975@wohnheim.fh-wedel.de> <200404141202.07021.Guillaume@Lacote.name> <407D3231.2080605@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407D3231.2080605@grupopie.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 01:44:33PM +0100, Paulo Marques wrote:
> Guillaume Lac?te wrote:
> 
> >>>Oops ! I thought it was possible to guarantee with the Huffman encoding
> >>>(which is more basic than Lempev-Zif) that the compressed data use no
> >>>more than 1 bit for every byte (i.e. 12,5% more space).
> 
> WTF??
> 
> Zlib gives a maximum increase of 0.1%  + 12 bytes (from the zlib manual), 
> which for a 512 block will be a 2.4% guaranteed increase.
> 
> I think that zlib already does the "if this is bigger than original, just 
> mark the block type as uncompressed" algorithm internally, so the increase 
> is minimal in the worst case.

It is my impression that meta-data is exactly what he wants to avoid as it would
provide known data for crackers
