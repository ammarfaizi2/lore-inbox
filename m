Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbUFBLwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUFBLwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 07:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUFBLwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 07:52:14 -0400
Received: from [213.146.154.40] ([213.146.154.40]:11648 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262045AbUFBLwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 07:52:07 -0400
Date: Wed, 2 Jun 2004 12:52:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Andrew Morton <akpm@osdl.org>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix dependeces for CONFIG_USB_STORAGE
Message-ID: <20040602115204.GA731@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paolo Ornati <ornati@fastwebnet.it>, Andrew Morton <akpm@osdl.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <200406021116.35529.ornati@fastwebnet.it> <20040602104900.GB32474@infradead.org> <200406021352.14561.ornati@fastwebnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406021352.14561.ornati@fastwebnet.it>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 01:52:14PM +0200, Paolo Ornati wrote:
> So if you want to use USB Mass Storage devices (that use SCSI emulation) you 
> need also SCSI disk support (I have realized it when I've tried to mount 
> one those USB devices, without success).

There's also external usb cdrom enclosures.  In which case you only need
sr.
