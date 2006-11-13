Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755174AbWKMQBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbWKMQBI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755173AbWKMQBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:01:08 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:25104 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1755174AbWKMQBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:01:07 -0500
Message-ID: <45589744.60601@cfl.rr.com>
Date: Mon, 13 Nov 2006 11:03:16 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Jurriaan <thunder7@xs4all.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: wanted: more informative message if root device can't be found/mounted
References: <20061111085200.GA4167@amd64.of.nowhere>
In-Reply-To: <20061111085200.GA4167@amd64.of.nowhere>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Nov 2006 16:01:12.0158 (UTC) FILETIME=[F0BB2FE0:01C7073C]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14810.003
X-TM-AS-Result: No--5.264600-5.000000-4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jurriaan wrote:
> I'm experimenting with turning off the PATA drivers and use SATA only,
> since all my devices are now found by the SATA drivers in
> 2.6.19-rc5-mm1.
> 
> There is one area in which the kernel could, I think, do better. When
> booting, there's no way for me to know where /dev/hda is going to end
> up.
> 


You might try using a distribution with an initramfs that performs 
proper hardware detection, and can mount the root volume by ID rather 
than device path.
