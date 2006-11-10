Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946660AbWKJOAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946660AbWKJOAb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 09:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946670AbWKJOAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 09:00:31 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:27264 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946660AbWKJOAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 09:00:30 -0500
Message-ID: <455485FC.1040607@garzik.org>
Date: Fri, 10 Nov 2006 09:00:28 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: "Michael D. Setzer II" <mikes@kuentos.guam.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Failure of sata_via with kernels since 2.6.15.6
References: <455501B3.13819.421AEC9@mikes.kuentos.guam.net>
In-Reply-To: <455501B3.13819.421AEC9@mikes.kuentos.guam.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael D. Setzer II wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I've been working on the g4l since version 0.15 thru 0.21. I've recently found that later kernels 
> no longer work with some sata controller. Below are the dmesg parts of the dmesg output of 
> a 2.6.15.6 that works fine with the controller. All later kernels showed results similar to the 
> 2.6.18.2 kernel. I've even tried using the 2.6.15.6  .config file as a source to build newer 
> kernels with the same results.  Unfortuntely, this machine is a primary server, so can only do 
> very limited testing. Have also seen the same problem with latest Knoppix not seeing the 
> SATA drive either. 

Can you try 2.6.19-rc5-git2?

There were very recent sata_via fixes pushed upstream.

	Jeff



