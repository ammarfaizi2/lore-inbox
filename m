Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266491AbSKZSnB>; Tue, 26 Nov 2002 13:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266520AbSKZSnB>; Tue, 26 Nov 2002 13:43:01 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:2963 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266491AbSKZSnA>; Tue, 26 Nov 2002 13:43:00 -0500
Subject: Re: PROBLEM: PDC20267 fails (in different ways) with 2.4.20-rc3 and
	2.4.20-rc2-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Burgess <aab@cichlid.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211261823.gAQIN7J17474@athlon.cichlid.com>
References: <200211261823.gAQIN7J17474@athlon.cichlid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Nov 2002 19:21:14 +0000
Message-Id: <1038338474.2534.69.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 18:23, Andrew Burgess wrote:
> I have a PDC20267 that works with 2.4.19-ac4.
> With 2.4.20-rc3 the machine hangs at checking filesystems.
> With 2.4.20-rc2-ac3 the machine boots but the PDC20267 is not detected at all.
>
Make sure you compiled in the pdc202xx_old driver - the pdc driver was
split into two

