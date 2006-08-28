Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWH1XGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWH1XGI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 19:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWH1XGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 19:06:08 -0400
Received: from smtp7.orange.fr ([193.252.22.24]:33521 "EHLO
	smtp-msa-out07.orange.fr") by vger.kernel.org with ESMTP
	id S1751406AbWH1XGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 19:06:06 -0400
X-ME-UUID: 20060828230604685.A77181C00084@mwinf0706.orange.fr
Date: Tue, 29 Aug 2006 01:04:52 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: debian-kernel@lists.debian.org, Greg KH <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Message-ID: <20060828230452.GA4393@powerlinux.fr>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> <1156803102.3465.34.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156803102.3465.34.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 05:11:42PM -0500, James Bottomley wrote:
> This is a reference implementation with the debian mkinitrd-tools
> package.  It shows how to identify the firmware files necessary for
> drivers in the initrd and also includes a primitive system for loading
> them.
> 
> I've tested this with the aic94xx driver using the new MODULE_FIRMWARE()
> tag.  Initramfs should be much easier because it already includes most
> of the boot time loading; all it has to do is the piece identifying the
> firmware for the selected modules.

Notice that mkinitrd-tools is dead, and will probably be removed from etch.

mkinitramfs-tools and yaird are the two currently used tools.

Friendly,

Sven Luther
