Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbSLHBMO>; Sat, 7 Dec 2002 20:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSLHBMO>; Sat, 7 Dec 2002 20:12:14 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:50869 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265095AbSLHBMN>; Sat, 7 Dec 2002 20:12:13 -0500
Subject: Re: 2.4.18 beats 2.5.50 in hard drive access????
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Cc: David Ashley <dash@xdr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1039235352.3232.22.camel@aurora.localdomain>
References: <200212062300.gB6N0jg10757@xdr.com>
	<1039227036.25004.0.camel@irongate.swansea.linux.org.uk> 
	<1039235352.3232.22.camel@aurora.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 01:55:42 +0000
Message-Id: <1039312542.27904.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA off is just a bit of excess noise in the IDE code - the VIA
driver turns DMA back on again

