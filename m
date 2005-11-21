Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVKUVfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVKUVfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVKUVfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:35:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:59109 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750833AbVKUVfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:35:09 -0500
Date: Mon, 21 Nov 2005 12:27:42 -0800
From: Greg KH <greg@kroah.com>
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about driver built-in kernel
Message-ID: <20051121202742.GA15957@kroah.com>
References: <08A354A3A9CCA24F9EE9BE13600CFBC501A31918@wcosmb07.cos.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08A354A3A9CCA24F9EE9BE13600CFBC501A31918@wcosmb07.cos.agilent.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 12:06:52PM -0700, yiding_wang@agilent.com wrote:
> Hello Greg,
> 
> Thanks for the support and prompt response. I figure it out the
> problem is endianess. I worked everything on x86 based system and
> copied files to PPC system. Somehow I forgot to change the endianess
> define in my makefile. Now everything works fine!

You should not need a endian define in your makefile, just use the
kernel build system and it will all work properly.

By your reluctance to show the source code, am I correct in assuming
that it is not released under the GPL?

thanks,

greg k-h
