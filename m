Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUHZEz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUHZEz2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUHZEz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:55:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28837 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267585AbUHZEzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:55:21 -0400
Date: Thu, 26 Aug 2004 05:55:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce size of struct inode on 64bit
Message-ID: <20040826045520.GS21964@parcelfarce.linux.theplanet.co.uk>
References: <20040826044113.GA10843@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826044113.GA10843@krispykreme>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 02:41:13PM +1000, Anton Blanchard wrote:
> 
> Reduce the size of struct inode on 64bit architectures by reducing padding.
> This assumes spinlocks are 32bit or less which is the case on most
> architectures.
> 
> This reduces inode structs by 24 bytes on ppc64, and on ext2 increases
> the number of inodes in a 4kB slab from 5 to 6.

ACK
