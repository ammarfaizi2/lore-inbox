Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbUENSjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUENSjS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUENSjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:39:18 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:51474 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262050AbUENSjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:39:16 -0400
Date: Fri, 14 May 2004 19:39:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: does udev support sw raid0?
Message-ID: <20040514193913.A27388@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>,
	Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
	linux-kernel@vger.kernel.org
References: <200405141442.38404.norberto+linux-kernel@bensa.ath.cx> <20040514183450.GA2345@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040514183450.GA2345@kroah.com>; from greg@kroah.com on Fri, May 14, 2004 at 11:34:50AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 11:34:50AM -0700, Greg KH wrote:
> Do your md raid devices show up in /sys/block?  If so, then udev should
> support them.  If not, then udev will not.

md has the chicken-egg problem of having to issue an ioctl on the md device
to register a gendisk. 

