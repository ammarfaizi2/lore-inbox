Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319353AbSIEXUX>; Thu, 5 Sep 2002 19:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319354AbSIEXUX>; Thu, 5 Sep 2002 19:20:23 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:55536
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319353AbSIEXUW>; Thu, 5 Sep 2002 19:20:22 -0400
Subject: Re: 2.4.20pre5 trivial assembler warning fix for pci-pc.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Steinmetz <ast@domdv.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D77BCEC.4070400@domdv.de>
References: <3D77BCEC.4070400@domdv.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 00:26:08 +0100
Message-Id: <1031268368.7900.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-05 at 21:22, Andreas Steinmetz wrote:
> trivial fix for "Warning: indirect lcall without `*'" assembler warnings
> attached.

I've always left those because there are still old binutils around that
misassemble with the "*". One for 2.5 IMHO

