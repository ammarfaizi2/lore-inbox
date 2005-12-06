Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVLFPhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVLFPhI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVLFPhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:37:07 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:3428 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP
	id S1750742AbVLFPhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:37:06 -0500
Date: Tue, 6 Dec 2005 17:36:45 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
In-Reply-To: <200512061426.37287.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.61.0512061707370.23913@zeus.compusonic.fi>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
 <20051205121851.GC2838@holomorphy.com> <20051206011844.GO28539@opteron.random>
 <200512061426.37287.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, Denis Vlasenko wrote:

> How about refusing binary-only modules instead? I mean, maybe
> if Linux will stop being lax about GPL requirements on modules.
Or why not to include an embedded version of gcc/binutils in the kernel
LKM interface. In this way all drivers can only be distributed in source 
code which effectively makes all forms of binary only drivers impossible. 
After that all the EXPORT_SYMBOL_GPL nonsense can be removed and a proper 
DDI layer can be implemented for Linux. This makes it possible to ship 
"outside the kernel build" drivers without a risk of major 
incompatibility problems in the next kernel version. No, I'm not 100% 
serious but just 50%.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
