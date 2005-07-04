Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVGDPnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVGDPnN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 11:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVGDPnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 11:43:13 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:27121 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261225AbVGDPlh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 11:41:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NVj4AIsv5WfROYUYBUoDOn2osHb0Bq74LISwuUR7IkkVAM068D0q3Bn/lo0qnvI4LUij/WqO2jNW0z8H8yXnOsjwUHrYZK1SXjse/fS4d9G2LwskhLgrkOQxTOMDLiayRTf0T49r2FkO9hZf0aYZbuVbgVvU7n/EQ/mhBc0DBYA=
Message-ID: <58cb370e05070408417dc3c067@mail.gmail.com>
Date: Mon, 4 Jul 2005 17:41:34 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [git patches] IDE update
Cc: Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200507041530.SAA02324@raad.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <58cb370e05070405302d47fdfd@mail.gmail.com>
	 <200507041530.SAA02324@raad.intranet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
> Bartlomiej Zolnierkiewicz wrote: {
> What is the "int/dma problem"?
> }
> 
> Hdparm -tT gives 38mb/s in 2.4.31
> Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle
> 
> Hdparm -tT gives 28mb/s in 2.6.12
> Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT
> 
> It feels like DMA is not being applied properly in 2.6.12.
> 
> Your comments please.

Are earlier 2.6.x kernels okay?

dmesg output?

Bartlomiej
