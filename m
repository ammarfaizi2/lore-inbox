Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVDPIrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVDPIrT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 04:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVDPIrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 04:47:18 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:57187 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261432AbVDPIrP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 04:47:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jOdz3Asi2JLZfpaw0iWlqexdPxaI5B4BRWB7IqhSMmLQJOme94fOIZkzTSq0IYHyTLsVpl+gkxY36EEionbm1wcoCbwsc9qBq0CKWVHSe7nY4ZtFo5zUF7nhLhfEJwyZQH9bmsKtq+wnXy9V0f8phugR8m7hXAlwH6T0rBNuy5s=
Message-ID: <21d7e99705041601476a147251@mail.gmail.com>
Date: Sat, 16 Apr 2005 18:47:13 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: "ross@lug.udel.edu" <ross@lug.udel.edu>
Subject: Re: DRM not working with 2.6.11.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050416070925.GA1237@jose.lug.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050416070925.GA1237@jose.lug.udel.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The AGP and DRM modules load fine, but when xdm starts, I have no
> direct rendering.
> 
> The machine is an ASUS A7V8x-x with VIA chipset KT400.  The video card
> is a Matrox G400 DualHead.  I've had the exact same video card working
> with different motherboards.
> 
> Here is the only DRM output relevant to AGP/DRM:
> 
> Linux agpgart interface v0.100 (c) Dave Jones
> [drm] Initialized drm 1.0.0 20040925
> [drm:drm_fill_in_dev] *ERROR* Cannot initialize the agpgart module.

You didn't load the agp chipset module..
it would be nice if it happened automatically...

Dave.
