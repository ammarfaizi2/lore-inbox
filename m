Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSE2RhX>; Wed, 29 May 2002 13:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSE2RhW>; Wed, 29 May 2002 13:37:22 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:2808 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314277AbSE2RhU>; Wed, 29 May 2002 13:37:20 -0400
Subject: Re: Orinoco Wireless driver bugs in 2.5.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Gibson <hermes@gibson.dropbear.id.au>
Cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020523012517.GM1001@zax>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 19:40:27 +0100
Message-Id: <1022697627.9255.272.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-23 at 02:25, David Gibson wrote:
> The signal/noise bit is probably a red herring.  We have problems with
> the reporting of this, but it's mostly cosmetic.  I seem to have
> confusing and contradictory information about how to interpret the
> values the firmware reports.

Ok the old driver gets the noise level right, the newer one got it
wrong, the current one gets it wrong. The good news is the old one
works, the new one didnt, the current 2.4.19pre one does...

Alan

