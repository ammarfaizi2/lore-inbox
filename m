Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUGTT5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUGTT5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266213AbUGTT4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:56:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25048 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266208AbUGTTzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:55:53 -0400
Date: Tue, 20 Jul 2004 20:55:52 +0100
From: Matthew Wilcox <willy@debian.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James.Bottomley@SteelEye.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] depends on PCI DMA API: Adaptec AIC7xxx_old
Message-ID: <20040720195552.GB2820@parcelfarce.linux.theplanet.co.uk>
References: <200407201839.i6KIdo2I015550@anakin.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407201839.i6KIdo2I015550@anakin.of.borg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 08:39:50PM +0200, Geert Uytterhoeven wrote:
> Adaptec AIC7xxx_old unconditionally depends on the PCI DMA API, so mark it
> broken if !PCI

Shouldn't we rather have dummy PCI DMA APIs?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
