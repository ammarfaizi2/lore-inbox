Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVHYIug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVHYIug (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 04:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVHYIug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 04:50:36 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:14482 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S964881AbVHYIuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 04:50:35 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andy Isaacson <adi@hexapodia.org>,
       moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: question on memory barrier
Date: Thu, 25 Aug 2005 11:49:46 +0300
User-Agent: KMail/1.5.4
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0508240854550.28064@chaos.analogic.com> <20050824173131.50938.qmail@web25809.mail.ukl.yahoo.com> <20050824194836.GA26526@hexapodia.org>
In-Reply-To: <20050824194836.GA26526@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508251149.46452.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You might benefit by running your source code through gcc -E and seeing
> what the writel() expands to.  (I do something like "rm drivers/mydev.o;
> make V=1" and then copy-n-paste the gcc line, replacing the "-c -o mydev.o"
> options with -E.)

Just use "make drivers/mydev.i"
--
vda

