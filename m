Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbUKVKnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbUKVKnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUKVKmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:42:19 -0500
Received: from sd291.sivit.org ([194.146.225.122]:43449 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262037AbUKVKet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:34:49 -0500
Date: Mon, 22 Nov 2004 11:35:20 +0100
From: Stelian Pop <stelian@popies.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com
Subject: Re: [PATCH] usb-storage should enable scsi disk in Kconfig
Message-ID: <20041122103520.GA3550@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, greg@kroah.com
References: <20041119193350.GE2700@deep-space-9.dsnet> <20041119195736.GA8466@infradead.org> <20041119213942.GG2700@deep-space-9.dsnet> <20041119230820.GB32455@one-eyed-alien.net> <419FD192.1040604@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419FD192.1040604@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 03:21:54PM -0800, Randy.Dunlap wrote:

> >>>On Fri, Nov 19, 2004 at 08:33:50PM +0100, Stelian Pop wrote:
> >>
> >>Maybe we should add, just below the 'USB storage' Kconfig option another
> >>one, let's say 'SCSI disk based USB storage support', which documentation
> >>would talk about 'usb keys, memory stick readers, USB floppy drives etc',
> >>which should just be a dummy option selecting  BLK_DEV_SD ?

> Until 'suggests' is available, does this help any?
> It's tough getting people to read Help messages though.
> 
> Add comment/NOTE that USB_STORAGE probably needs BLK_DEV_SD also.
> Add a few device types to help text and reformat it.

Isn't my above suggestion even better ? A separate config option
is much more visible IMHO...

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
