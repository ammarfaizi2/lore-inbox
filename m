Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbUCXQqe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 11:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUCXQqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 11:46:34 -0500
Received: from mail.kroah.org ([65.200.24.183]:20355 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263017AbUCXQqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 11:46:32 -0500
Date: Wed, 24 Mar 2004 08:45:56 -0800
From: Greg KH <greg@kroah.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       claus@momo.math.rwth-aachen.de
Subject: Re: [PATCH 2.6 RFT] add class support to floppy tape driver zftape-init.c
Message-ID: <20040324164556.GA20767@kroah.com>
References: <58110000.1079739485@w-hlinder.beaverton.ibm.com> <16481.34778.399231.603762@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16481.34778.399231.603762@alkaid.it.uu.se>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 02:06:34PM +0100, Mikael Pettersson wrote:
> Hanna Linder writes:
>  > Here is a patch to add class support to zftape-init.c:
>  > 
>  > MODULE_DESCRIPTION(ZFTAPE_VERSION " - "
>  >                    "VFS interface for the Linux floppy tape driver. "
>  >                    "Support for QIC-113 compatible volume table "
>  >                    "and builtin compression (lzrw3 algorithm)");
>  > 
>  > I have verified it compiles but do not have the hardware to test it.
>  > If someone who does could test it please do.
> 
> Tested in a monolithic 2.6.5-rc2 kernel. No observable breakage.

Great, thanks for testing.

> All it does is add some dev nodes in sysfs. How useful is that?

Very useful.  It allows this device to be used when using a tool like
udev to manage your /dev tree.

thanks,

greg k-h
