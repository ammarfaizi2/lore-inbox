Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262494AbTCRSP4>; Tue, 18 Mar 2003 13:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262497AbTCRSP4>; Tue, 18 Mar 2003 13:15:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2541
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262494AbTCRSP4>; Tue, 18 Mar 2003 13:15:56 -0500
Subject: Re: IDE 48 bit addressing causes data corruption
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Felix Domke <tmbinc@elitedvb.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E77635D.5080306@elitedvb.net>
References: <3E772DA1.5080504@elitedvb.net>
	 <1048004672.27223.65.camel@irongate.swansea.linux.org.uk>
	 <3E77635D.5080306@elitedvb.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048016235.27370.84.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 18 Mar 2003 19:37:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 18:20, Felix Domke wrote:
> Why does a certain IDE controller not support LBA48?

In DMA mode some of them have state machines that know too much.
The double pump of the control registers confuses them.


