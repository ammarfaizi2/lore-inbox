Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbUKEOox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbUKEOox (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbUKEOox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:44:53 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:16909 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262705AbUKEOoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:44:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qNYNkGMp0IMilb2JwVw9EmjQaylD74HKa7o7ZwNmglKzPggBEDg1TmkRHYxL+IMptGxFwGjsENl0ze3ZRkp+6DTpr1nkFDBQ73CTPty9ZtH0dPE2SQKPZbvOocgbDXtntnIbbHoZ3cDUCbD9vXeymB6vwUfy4yV9rUkZCHW+aGo=
Message-ID: <5b64f7f04110506433c69122e@mail.gmail.com>
Date: Fri, 5 Nov 2004 09:43:59 -0500
From: Rahul Karnik <deathdruid@gmail.com>
Reply-To: Rahul Karnik <deathdruid@gmail.com>
To: linux-os@analogic.com
Subject: Re: Linux-2.6.9 won't allow a write to a NTFS file-system.
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       Giuseppe Bilotta <bilotta78@hotpop.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411041721110.9510@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.61.0411041054370.4818@chaos.analogic.com>
	 <MPG.1bf47baa1b621da0989706@news.gmane.org>
	 <Pine.LNX.4.61.0411041158010.5193@chaos.analogic.com>
	 <Pine.LNX.4.60.0411042216340.5130@hermes-1.csi.cam.ac.uk>
	 <Pine.LNX.4.61.0411041721110.9510@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004 17:38:53 -0500 (EST), linux-os
<linux-os@chaos.analogic.com> wrote:
> I thought maybe that was so, so I tried to format it as a
> FAT-32 drive and W$ complained that it was too large. So
> I thought, I would just partition it, but I never partitioned
> it to two logical drives before before so I don't know
> what's changed (it's W/2000). Right now, I am partitioning
> it to two slices and formatting it with FAT-32.

Note that mkfs.vfat will format up to the maximum size allowed by the
FAT32 spec, rather than the 32 GB limit imposed by Windows. I am using
a 120 GB VFAT partition to share data between Windows and Linux.

Thanks,
Rahul
