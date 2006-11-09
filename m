Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424186AbWKISX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424186AbWKISX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 13:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424187AbWKISX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 13:23:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2012 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1424186AbWKISX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 13:23:58 -0500
Subject: Re: Abysmal PATA IDE performance
From: Arjan van de Ven <arjan@infradead.org>
To: Stephen.Clark@seclark.us
Cc: "\"\\\"J.A.\\\"" =?ISO-8859-1?Q?Magall=F3n=22?= 
	<jamagallon@ono.com>,
       =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Mark Lord <lkml@rtr.ca>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45536653.50006@seclark.us>
References: <455206E7.2050104@seclark.us> <45526D50.5020105@rtr.ca>
	 <455277E1.3040803@seclark.us> <20061109020758.GA21537@atjola.homenet>
	 <4552A638.4010207@seclark.us>  <20061109094014.1c8b6bed@werewolf-wl>
	 <1163062700.3138.467.camel@laptopd505.fenrus.org>
	 <45533DB9.4000405@seclark.us>
	 <1163084045.3138.502.camel@laptopd505.fenrus.org>
	 <45536653.50006@seclark.us>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 09 Nov 2006 19:23:49 +0100
Message-Id: <1163096630.3138.515.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ata2.01: ATAPI, max UDMA/33
> ata2.00: configured for UDMA/33 <==== why isn't this 66 or 100 ?
> ===============****


you need a different cable for udma66 than you need for udma33; and a
certain capacitor to be able to autodetect which you have...
maybe your laptop maker saved himself $0.05 ;)
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

