Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbUKSUAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbUKSUAa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 15:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbUKST6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 14:58:11 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:32008 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261560AbUKST5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 14:57:45 -0500
Date: Fri, 19 Nov 2004 19:57:36 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Stelian Pop <stelian@popies.net>, mdharm-usb@one-eyed-alien.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] usb-storage should enable scsi disk in Kconfig
Message-ID: <20041119195736.GA8466@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stelian Pop <stelian@popies.net>, mdharm-usb@one-eyed-alien.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20041119193350.GE2700@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119193350.GE2700@deep-space-9.dsnet>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 08:33:50PM +0100, Stelian Pop wrote:
> As $subject says, usb-storage storage should automatically enable
> scsi disk support in Kconfig.
> 
> Please apply.

No, it shouldn't.  There's lots of usb storage devices that don't use
sd, as there are lots of SPI/FC/etc.. devices.

