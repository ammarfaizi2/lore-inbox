Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSLZL63>; Thu, 26 Dec 2002 06:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSLZL63>; Thu, 26 Dec 2002 06:58:29 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:26280 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261375AbSLZL63>; Thu, 26 Dec 2002 06:58:29 -0500
Date: Thu, 26 Dec 2002 13:06:28 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nikolai Zhubr <s001@hotbox.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4.20/drivers/ide/pdc202xx.c
Message-ID: <20021226120628.GD7348@louise.pinerecords.com>
References: <1876003973.20021224013519@hotbox.ru> <1040851745.1109.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040851745.1109.7.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2002-12-23 at 22:35, Nikolai Zhubr wrote:
> > Hi, this patch fixes misdetection of 80-pin vs 40-pin IDE cable
> > connected to Promise 202xx IDE controller (kernel 2.4.20). The original
> 
> 2.4.21pre updates the IDE massively. This should already be fixed

Well it's fixed but a new bug has been introduced.  2.4.21-pre2 won't
let you set UDMA3+ on the secondary channel of a PDC20268 no matter what,
even ide1=ata66 is no use.

-- 
Tomas Szepe <szepe@pinerecords.com>
