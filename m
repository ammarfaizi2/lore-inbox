Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbTCRPDR>; Tue, 18 Mar 2003 10:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbTCRPDR>; Tue, 18 Mar 2003 10:03:17 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49642
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262457AbTCRPDQ>; Tue, 18 Mar 2003 10:03:16 -0500
Subject: Re: IDE 48 bit addressing causes data corruption
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Felix Domke <tmbinc@elitedvb.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E772DA1.5080504@elitedvb.net>
References: <3E772DA1.5080504@elitedvb.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048004672.27223.65.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 18 Mar 2003 16:24:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 14:30, Felix Domke wrote:
> Can somebody please confirm again that i don't need an atapi-6 (ATA133) 
> controller to use LBA48 ?
> 
> Regulary some people are stating this, and regulary some people tell 
> that these people are wrong.

LBA48 support and UDMA100/133 support are unrelated to one another.
There are controllers with one or the other, eg the older ALi can do
UDMA133 but not LBA48

Consult your IDE controller vendor

