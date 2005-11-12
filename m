Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVKLHMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVKLHMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 02:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVKLHMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 02:12:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42380 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932306AbVKLHMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 02:12:14 -0500
Date: Sat, 12 Nov 2005 07:12:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       jonathan@buzzard.org.uk, tlinux-users@linux.toshiba-dme.co.jp,
       Jaroslav Kysela <perex@suse.cz>, viro@ftp.linux.org.uk
Subject: Re: [RFC: 2.6 patch] remove ISA legacy functions
Message-ID: <20051112071201.GA29136@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	netdev@vger.kernel.org, jonathan@buzzard.org.uk,
	tlinux-users@tce.toshiba-dme.co.jp, Jaroslav Kysela <perex@suse.cz>,
	viro@ftp.linux.org.uk
References: <20051107200336.GH3847@stusta.de> <20051110042857.38b4635b.akpm@osdl.org> <20051111021258.GK5376@stusta.de> <20051110182443.514622ed.akpm@osdl.org> <20051111201849.GP5376@stusta.de> <20051111202005.GQ5376@stusta.de> <20051111203601.GR5376@stusta.de> <20051112045216.GY5376@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051112045216.GY5376@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 05:52:16AM +0100, Adrian Bunk wrote:
> This patch removes the ISA legacy functions that are deprecated since 
> kernel 2.4 and that aren't available on all architectures.
> 
> The 7 drivers that were still using this obsolete API are now marked
> as BROKEN.

NACK.  Al has patches pending to convert them to proper APIs, please
wait until after that patchseries has landed.

