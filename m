Return-Path: <linux-kernel-owner+w=401wt.eu-S1754276AbWL3JSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbWL3JSE (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 04:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754280AbWL3JSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 04:18:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36982 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276AbWL3JSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 04:18:03 -0500
Date: Sat, 30 Dec 2006 09:18:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adam Megacz <megacz@cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OpenAFS gatekeepers request addition of AFS_SUPER_MAGIC to magic.h
Message-ID: <20061230091800.GA14871@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adam Megacz <megacz@cs.berkeley.edu>, linux-kernel@vger.kernel.org
References: <x3fyay2r4z.fsf@nowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x3fyay2r4z.fsf@nowhere.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 03:56:12PM -0800, Adam Megacz wrote:
> 
> Hello,
> 
> Jeffrey Altman, one of the gatekeepers of OpenAFS (the open source
> project which inherited the Transarc/IBM AFS codebase) has requested
> that the magic number 0x5346414F (little endian 'OAFS') be allocated
> for the f_type field of the fsinfo structure on Linux:
> 
>   https://lists.openafs.org/pipermail/openafs-info/2006-December/024829.html
> 
> I would like to offer the patch below for inclusion in the source
> tree, if possible.  The patch adds it to include/linux/magic.h, mostly
> as a way of publishing this number and ensuring that no other
> filesystem accidentally uses it.

We're not allocating these number for any other out of teee junk like vxfs
or gpfs either.  So I'd say stay away.


p.s. and please stop that namedropping - beeing a 'gatekeeper' doesn't
	make you any more important than just beeing yourself

