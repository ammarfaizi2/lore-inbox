Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVDVTFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVDVTFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 15:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVDVTFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 15:05:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46030 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262110AbVDVTFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 15:05:31 -0400
Date: Fri, 22 Apr 2005 20:05:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 10/12] s390: remove ioctl32 from dasdcmb.
Message-ID: <20050422190527.GA2359@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20050422150238.GJ17508@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050422150238.GJ17508@mschwid3.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2005 at 05:02:38PM +0200, Martin Schwidefsky wrote:
> +#if defined(CONFIG_DASD_CMB) || defined(CONFIG_DASD_CMB_MODULE)
> +COMPATIBLE_IOCTL(BIODASDCMFENABLE)
> +COMPATIBLE_IOCTL(BIODASDCMFDISABLE)
> +COMPATIBLE_IOCTL(BIODASDREADALLCMB)
> +#endif

I don't think that there should be ifdefs for COMPATIBLE_IOCTL entries.

