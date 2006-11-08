Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423688AbWKHUqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423688AbWKHUqk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423698AbWKHUqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:46:40 -0500
Received: from nz-out-0102.google.com ([64.233.162.199]:8911 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1423688AbWKHUqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:46:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pg749rRrXZ3sjoHph7hqF5ANFil3mI6Lfkzg/Ox6M81BVbuwa/r+YL7lFMJ+YN9lD4eIyNfkv2wVGOwkjU9fiQ0TIgl3b3LMaLz/RTN9HyzDpFL5fndbYAyRYtBT9EZoF0OTzxZWezyrAuWssdK7t9DBnl/ml+OkHUwW+62isVc=
Message-ID: <1defaf580611081246p7158e083h9e3658f2344ed121@mail.gmail.com>
Date: Wed, 8 Nov 2006 21:46:37 +0100
From: "Haavard Skinnemoen" <hskinnemoen@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [-mm patch 0/2] MACB driver update
Cc: "Haavard Skinnemoen" <hskinnemoen@atmel.com>,
       "Andrew Victor" <andrew@sanpeople.com>,
       "Jeff Garzik" <jgarzik@pobox.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061108115039.58e7f6f5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061108203358.558c28d3@cad-250-152.norway.atmel.com>
	 <20061108115039.58e7f6f5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/06, Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 8 Nov 2006 20:33:58 +0100
> Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> Patches have names.  I currently have

Sorry. I meant that you can drop these:

> gpio-framework-for-avr32.patch
> avr32-spi-ethernet-platform_device-update.patch
> avr32-move-spi-device-definitions-into-main-board.patch
> avr32-move-ethernet-tag-parsing-to-board-specific.patch

and keep these:

> atmel-spi-driver.patch
> atmel-spi-driver-maintainers-entry.patch
> atmel-macb-ethernet-driver.patch
> adapt-macb-driver-to-net_device-changes.patch
>
> I'd prefer to drop the lot, but we do have those SPI patches which David
> needs to see.

Ok, just do that. We need to get the GPIO stuff sorted out before the
SPI driver can be considered final.

> So in fact I do think I'd prefer to drop everything.  How about
>
> a) you sort out the SPI patches with David, send them over to me when
>    it's ready and
>
> b) everything else goes into Linus from your git tree, and I include
>    your git tree in -mm?

Fine with me. Sorry for pushing this mess to you. I'll post a new macb
patch for review to the netdev list tomorrow.

> (I hope that tree works, btw - for some reason it seems that any git tree
> which isn't on kernel.org is down half the time).

I hope so too. I'll pull from it myself from time to see how it works.

Haavard
