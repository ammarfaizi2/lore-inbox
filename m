Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274434AbRITMGB>; Thu, 20 Sep 2001 08:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274438AbRITMFv>; Thu, 20 Sep 2001 08:05:51 -0400
Received: from ns.suse.de ([213.95.15.193]:31756 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S274434AbRITMFg>;
	Thu, 20 Sep 2001 08:05:36 -0400
Date: Thu, 20 Sep 2001 14:05:58 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: David Chow <davidchow@rcn.com.hk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA Cyrix C3/MIII CPU
In-Reply-To: <3BA98E0F.F4C052BD@rcn.com.hk>
Message-ID: <Pine.LNX.4.30.0109201403190.23750-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, David Chow wrote:

> I am testing my board using the Cyrix C3 733 CPU. After installing the
> newly compiled kernel 2.4.7 , after the message "freeing unsused memory"
> and hangs... anyone has this before? I am using the new VIA 694T chipset
> . Or anyone test the Cyrix C3 CPU? Thanks

What target did you compile your kernel for ?
Choose either CyrixIII or 586 or less, as it's missing the CMOV
instruction.  My 866 has been completely stable during tests the
last week or so, even with me playing with the multiplier adjusting
MSRs etc..

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

