Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVEDUUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVEDUUH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVEDUUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:20:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:8066 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261399AbVEDUUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:20:01 -0400
Date: Wed, 4 May 2005 13:20:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: dmo@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DAC960: add support for Mylex AcceleRAID 4/5/600
Message-Id: <20050504132032.3aed8ce8.akpm@osdl.org>
In-Reply-To: <20050504181721.GA19777@lst.de>
References: <20050425141738.GA2749@lst.de>
	<20050504181721.GA19777@lst.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> > This patch adds support for a new class of DAC960 controllers.  It's
> > based on the GPLed idac320 driver from IBM for Linux 2.4.18.  That
> > driver is a fork of the 2.4.18 version of DAC960 that adds support for
> > this new type of controllers (internally called "GEM Series"), that
> > differ from other DAC960 V2 firmware controllers only in the register
> > offsets and removes support for all others.
> > 
> > This patch instead integrates support for these controllers into the
> > DAC960 driver.
> > 
> > Thanks to Anders Norrbring for pointing me to the idac320 driver and
> > testing this patch.
> > 
> > No Signed-Off: line because all code is either copy & pasted from IBM's
> > idac320 driver or support for other controllers in the 2.6 DAC960
> > driver.

I think a S-O-B is still appropriate in this case.  You worked on it, so..

> > Note: the really odd formating matches the rest of the DAC960 driver.

Yeah, maybe a big Lindenting is called for.  Although that would make
patches such as this one a heck of a lot harder.
