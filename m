Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbUKHV4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUKHV4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUKHVzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:55:35 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:42512 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261260AbUKHVyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:54:13 -0500
Date: Mon, 8 Nov 2004 22:54:02 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't divide by 0 when trying to mount ext3
Message-ID: <20041108215402.GB2946@pclin040.win.tue.nl>
References: <20041108195934.GA29981@apps.cwi.nl> <20041108212711.GA16365@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108212711.GA16365@bitwizard.nl>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 10:27:11PM +0100, Rogier Wolff wrote:

> There are now three cases that end up with the same message and
> same error from userspace viewpoint. There are many cases where 
> debugging a problem is helped when it's possible to find out exactly
> which test determined that the filesystem could not be mounted. 

Strings are expensive. Don't like to add worthless code.
We lived without this for years, so it is not a frequent occurrence.
If you have a bad ext2/ext3 system, e2fsck will find what is wrong.
