Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVGEGOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVGEGOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 02:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVGEGOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 02:14:47 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62882 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261201AbVGEGOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 02:14:46 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Tue, 5 Jul 2005 09:14:30 +0300
User-Agent: KMail/1.5.4
Cc: Alexander Nyberg <alexn@telia.com>, linux-kernel@vger.kernel.org
References: <20050607212706.GB7962@stusta.de> <200506081513.09828.vda@ilport.com.ua> <20050704182237.GW5346@stusta.de>
In-Reply-To: <20050704182237.GW5346@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507050914.30701.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > NB: gcc 3.4.3 can use excessive stack in degenerate cases, so please
> > > > include gcc version in your reports.
> > > 
> > > But this can't occur in the kernel.
> > 
> > It can. I saw the OOPS myself.
> > One of the functions in crypto/wp512.c was compiled with 3k+ stack usage.
> 
> Strange that "make checkstack" didn't show this.

It happens with certain gcc versions only.
 
> Are there any other 4KSTACKS problems you know about?

Currently no.
--
vda

