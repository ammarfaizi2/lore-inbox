Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270050AbRIABY7>; Fri, 31 Aug 2001 21:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269868AbRIABYu>; Fri, 31 Aug 2001 21:24:50 -0400
Received: from f271.law7.hotmail.com ([216.33.236.149]:54799 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S269971AbRIABYe>;
	Fri, 31 Aug 2001 21:24:34 -0400
X-Originating-IP: [211.117.39.54]
From: "Tobin Park" <shinywind@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: In ip.c (Kernel 1.3.0)
Date: Sat, 01 Sep 2001 01:24:47 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F27139LktrLEzdzF2tl000039cc@hotmail.com>
X-OriginalArrivalTime: 01 Sep 2001 01:24:47.0644 (UTC) FILETIME=[E377DDC0:01C13284]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I am studying linux kernel 1.3.0.

In ip.c this sentence appeared.

if(iph->frag_off)
	{
		if (iph->frag_off & 0x0020)
			is_frag|=1;
		/*
		 *	Last fragment ?
		 */

		if (ntohs(iph->frag_off) & 0x1fff)
			is_frag|=2;
	}


what is that mean is_frag?
what's the difference between is_frag are 1,2,4?

Thank you.

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

