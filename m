Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbVLJE2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVLJE2N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 23:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbVLJE2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 23:28:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:63123 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964916AbVLJE2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 23:28:12 -0500
Date: Fri, 9 Dec 2005 18:57:21 -0800
From: Greg KH <greg@kroah.com>
To: Bao Zhao <baozhaolinuxer@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: typo in debugfs code comments?
Message-ID: <20051210025720.GA17847@kroah.com>
References: <20051210020134.94755.qmail@web31712.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051210020134.94755.qmail@web31712.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 06:01:34PM -0800, Bao Zhao wrote:
>   I think that the comments of debugfs_create_u16 and
> debugfs_create_u32 
> have the copy and paste error.
>   
> below is original comments.
> /**
>  * debugfs_create_u16 - create a file in the debugfs
> filesystem that is used to read and write a unsigned 8
> bit value.
>  *
> 
> /**
>  * debugfs_create_u32 - create a file in the debugfs
> filesystem that is used to read and write a unsigned 8
> bit value.
>  *
> 
> It should be "a unsigned 16 bit value" and "a unsigned
> 32 bit value"

Heh, cut and paste comments :)

Care to send me a patch, as per Documentation/SubmittingPatches to fix
this up?

thanks,

greg k-h
