Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264089AbTDWPin (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTDWPin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:38:43 -0400
Received: from area9.server-home.net ([62.208.70.38]:42757 "EHLO AREA-9")
	by vger.kernel.org with ESMTP id S264089AbTDWPil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:38:41 -0400
Date: Wed, 23 Apr 2003 17:50:46 +0200
From: Walter Hofmann <nforce2-030422223536-fcf8@secretlab.mine.nu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nforce2 IDE DMA stopped working (2.4.21-rc1)
Message-ID: <20030423155046.GA1124@secretlab.mine.nu>
References: <20030422205721.GA1123@secretlab.mine.nu> <1051049388.15763.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051049388.15763.3.camel@dhcp22.swansea.linux.org.uk>
X-GPG-Fingerprint: 91D7 2B68 786F 7A3D 18FF E168 EAF4 8754
X-GPG-Key: http://search.keyserver.net:11371/pks/lookup?search=0xDE547385&op=index
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 23 Apr 2003 15:47:33.0062 (UTC) FILETIME=[A7800E60:01C309AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003, Alan Cox wrote:

> On Maw, 2003-04-22 at 21:57, Walter Hofmann wrote:
> > Using 2.4.20 I could enable DMA using "hdparm -d1 /dev/hda", but with 
> > 2.4.21-rc1 I get "HDIO_SET_DMA failed: Operation not permitted".
> > This is with a nForce2 chipset.
> 
> You dont appear to have the right drivers included in your kernel build.
> At least the boot has no mentuon of the AMD/Nvidia driver

You were right, I didn't select the correct driver. It works now!

Thanks,

Walter
