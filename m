Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267691AbSLGB1a>; Fri, 6 Dec 2002 20:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267692AbSLGB1a>; Fri, 6 Dec 2002 20:27:30 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:40627 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267691AbSLGB1a>; Fri, 6 Dec 2002 20:27:30 -0500
Subject: Re: 2.4.18 beats 2.5.50 in hard drive access????
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Ashley <dash@xdr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212062300.gB6N0jg10757@xdr.com>
References: <200212062300.gB6N0jg10757@xdr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Dec 2002 02:10:36 +0000
Message-Id: <1039227036.25004.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 23:00, David Ashley wrote:
> hda is an IDE cdrom drive, but here it is:

Ok that would explain why DMA is off on it. The disk puzzles me - for an
OSB4 the code should be selecting MWDMA2

