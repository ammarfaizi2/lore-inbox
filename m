Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbULKLXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbULKLXM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 06:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbULKLXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 06:23:12 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:36835 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261925AbULKLXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 06:23:09 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org, rudi@asics.ws
Subject: Re: kernel (64bit) 4GB memory support
Date: Sat, 11 Dec 2004 11:22:58 +0000
User-Agent: KMail/1.7
Cc: Jeff Garzik <jgarzik@pobox.com>
References: <1102752990.17081.160.camel@cpu0> <41BAC68D.6050303@pobox.com> <1102760002.10824.170.camel@cpu0>
In-Reply-To: <1102760002.10824.170.camel@cpu0>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412111122.58178.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 Dec 2004 10:13, Rudolf Usselmann wrote:
>
> Yes, but it is currently broken (kernel panics). I wonder
> if anybody knew which kernel does work for 64 bit and >4GB
> of memory. I'm sure there must be people out there with
> similar configurations to mine ....
>

There are, but most I've had discussions with on LKML and x86-4 ML are running 
recent 2.6 series kernels (successfully).

Best advice is 

1) Upgrade your bios to latest. Bios problems seem to account for most >4Gb 
mem problems on x86_64. Pay careful attention to bios memory settings also.

2) Report problems using lastest 2.4 kernel here for help

If you can use 2.6 kernel, you're likely to get more help. 2.4 is in 
maintenance mode. Most people here will be running/developing 2.6

Andrew Walrond
