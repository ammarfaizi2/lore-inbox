Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUCAPWy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 10:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbUCAPWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 10:22:53 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:50348 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261321AbUCAPWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 10:22:52 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Organization: Croadria Internet usluge
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Known problems with megaraid under 2.4.25 highmem?
Date: Mon, 1 Mar 2004 16:25:37 +0100
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, Atul Mukker <atulm@lsil.com>
References: <200402271107.42050.tvrtko@croadria.com> <Pine.LNX.4.58L.0402271548290.18958@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402271548290.18958@logos.cnet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200403011625.37224.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Not known to me...
>
> Can you get any traces from the lockup? NMI watchdog or sysrq+p and +t?
>
> Did any previous 2.4.x work reliably?

I can confirm that it is not highmem related because today we had the same 
lockup on 2.4.25 wo/highmem. Only thing left to be ruled out is grsec patch. 
It will be tested soon and then I will inform you.

What is the status of megaraid2 driver? Is it safe to use it in production or 
that isn't recommended?

