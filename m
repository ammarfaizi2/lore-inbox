Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWKHQMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWKHQMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWKHQMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:12:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5557 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030352AbWKHQMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:12:34 -0500
Date: Wed, 8 Nov 2006 16:12:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Weber <Martin.Weber@cern.ch>
Cc: Linux List <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at include/linux/dcache.h:303
Message-ID: <20061108161232.GA19284@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Weber <Martin.Weber@cern.ch>,
	Linux List <linux-kernel@vger.kernel.org>
References: <200611081708.43932.Martin.Weber@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611081708.43932.Martin.Weber@cern.ch>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 05:08:43PM +0100, Martin Weber wrote:
> Hi,
> 
> found the following message (see attached file), shortly after the system 
> died...
> 
> Kind regards,
> 
> Martin

> VFS: Busy inodes after unmount of shfs. Self-destruct in 5 seconds.  Have a nice day...
> ------------[ cut here ]------------
> kernel BUG at include/linux/dcache.h:303!
> invalid opcode: 0000 [#1]
> PREEMPT
> Modules linked in: shfs radeon drm ipw2100 joydev
> CPU:    0
> EIP:    0060:[<c0169b6d>]    Tainted: P      VLI

Whatever propritary module shfs is it's most likely the cause.
Please try again without it.

