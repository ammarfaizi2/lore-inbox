Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbTFMIfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbTFMIfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:35:53 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5552
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265263AbTFMIft convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:35:49 -0400
Subject: Re: ide0: reset: master: ECC circuitry error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin =?iso-8859-2?Q?MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.OSF.4.51.0306121955001.303628@tao.natur.cuni.cz>
References: <Pine.OSF.4.51.0306121955001.303628@tao.natur.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1055494032.5163.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jun 2003 09:47:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-06-12 at 19:18, Martin MOKREJŠ wrote:
> I saw this with earlier kernels ... In principle the laptop ASUS 3800C
> works fine. It happens only when "hdparm -d1 /dev/discs/disc0/disc" is
> executed during boot. The ide devices are:

You probably need to set up the DMA speed on the drive/controller too

	hdparm -X66 -d1 



Your report also doesnt say which IDE controller

