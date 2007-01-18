Return-Path: <linux-kernel-owner+w=401wt.eu-S932152AbXARK0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbXARK0i (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 05:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbXARK0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 05:26:38 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:37332 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932152AbXARK0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 05:26:37 -0500
Date: Thu, 18 Jan 2007 11:25:00 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Cedric Le Goater <clg@fr.ibm.com>
cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]  Add new categories of DEPRECATED and OBSOLETE.
In-Reply-To: <45AF3942.9070701@fr.ibm.com>
Message-ID: <Pine.LNX.4.61.0701181123440.19740@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0701171745480.4740@CPE00045a9c397f-CM001225dbafb6>
 <45AF3942.9070701@fr.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>   Next to EXPERIMENTAL, add two new kernel config categories of
>> DEPRECATED and OBSOLETE.
>
>What about adding some printks when DEPRECATED and OBSOLETE are 
>set ? like in print_tainted() for example. 

Uhm no. I don't want a load of messages just because one of these 
options is active. I'd much rather prefer that when loading a _specific 
module_ depends on DEPRECATED/OBSOLETE, a message is printed. But that's 
an extra which I doubt it is worth modifying the kernel module structure 
for.



	-`J'
-- 
