Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263677AbUCUQ57 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 11:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbUCUQ57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 11:57:59 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:43282 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263677AbUCUQ56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 11:57:58 -0500
Date: Sun, 21 Mar 2004 16:57:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linguist@masterlinkcorp.com, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix tiocgdev 32/64bit emul
Message-ID: <20040321165752.A9028@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>, linguist@masterlinkcorp.com,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
	Andrew Morton <akpm@osdl.org>
References: <20040321062435.GA27226@goblin.masterlinkcorp.com> <405DC698.4040802@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <405DC698.4040802@pobox.com>; from jgarzik@pobox.com on Sun, Mar 21, 2004 at 11:45:12AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 11:45:12AM -0500, Jeff Garzik wrote:
> Yup, looks like a real bug to me...  good catch.
> 
> Untested but obvious patch attached.

Isn't that SuSE's strange ioctl hack that has been rejected for mainline
multiple times?  why does x86_64 have an emulation for it if the ioctl
isn't implemented anyway?

