Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282097AbRKWJo1>; Fri, 23 Nov 2001 04:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282093AbRKWJoR>; Fri, 23 Nov 2001 04:44:17 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:42814 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S282094AbRKWJoA> convert rfc822-to-8bit; Fri, 23 Nov 2001 04:44:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: William Park <opengeometry@yahoo.ca>, linux-kernel@vger.kernel.org
Subject: Re: PC-133 RAM + VIA 686B -> 4 x DIMM or 3 x DIMM ?
Date: Fri, 23 Nov 2001 10:43:20 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011123043303.A3043@node0.opengeometry.ca>
In-Reply-To: <20011123043303.A3043@node0.opengeometry.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E167CsI-0004Xg-00@mrvdom03.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm confused by conflicting rumors about VIA 686B chipset:
>     - some people can get only 3 x DIMM working at PC-133.
>     - others report that all 4 x DIMM are working at PC-133.

First of all: 
This is offtopic for the ___linux kernel___ mailing list.

Nevertheless:
VIA686B is the southbridge and has no memory controller.
The VIA694X-northbridge has 6 memory banks.

if the 3rd and 4th module are single sided its ok. 
If the 3rd module is double sided you cannot plugin a 4th module.

