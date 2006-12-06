Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760462AbWLFKeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760462AbWLFKeL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 05:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760465AbWLFKeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 05:34:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60305 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760461AbWLFKeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 05:34:09 -0500
Date: Wed, 6 Dec 2006 10:38:48 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Ian Romanick <idr@us.ibm.com>, linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] VIA and SiS AGP chipsets are x86-only
Message-ID: <20061206103848.4e3fb0cc@localhost.localdomain>
In-Reply-To: <20061206034044.GS3013@parisc-linux.org>
References: <20061204104314.GB3013@parisc-linux.org>
	<4575F929.9020708@us.ibm.com>
	<20061206034044.GS3013@parisc-linux.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 20:40:45 -0700
Matthew Wilcox <matthew@wil.cx> wrote:

> On Tue, Dec 05, 2006 at 02:56:41PM -0800, Ian Romanick wrote:
> > I don't know about SiS, but this is certainly *not* true for Via.  There
> > are some PowerPC and, IIRC, Alpha motherboards that have Via chipsets.
> 
> Yes, but they don't have VIA *AGP*.  At least, that's what I've been
> told by people who know those architectures.

VIA south gets used by a lot of the systems but the VIA North bridges
I've got docs for cover only x86 variants, although one of the older ones
implies it has both K7 and Alpha support (just as the AMD chipset does)

Personally I'd rather know when I broke stuff by getting everything
to compile that sanely compiles. Operating the ".config" file is not
complex after all.

Alan
