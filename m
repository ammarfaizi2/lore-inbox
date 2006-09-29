Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422822AbWI2UkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbWI2UkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbWI2UkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:40:12 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:63250 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1422822AbWI2UkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:40:10 -0400
Date: Fri, 29 Sep 2006 16:29:34 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, jt@hpl.hp.com
Subject: Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA
Message-ID: <20060929202928.GA14000@tuxdriver.com>
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 09:25:53PM +0200, Alessandro Suardi wrote:
> Dell Latitude D610, FC5-latest, ipw2200 configured to associate
> with a D-Link DSL-G604T (combo of router/ADSL modem/802.11g AP).
> 
> 2.6.18-git8 (plus semaphore.h) is ok
> -git9, -git10, -git11 fail to associate
> -git11 with reverted wireless changes is ok
> 
> Attaching diff of what I reverted in -git11 to make it work again.
> 
> wpa_supplicant log of failing session available upon request.

It looks like you reverted the WE-21 stuff.  Is your wireless-tools
package up to date?

John
-- 
John W. Linville
linville@tuxdriver.com
