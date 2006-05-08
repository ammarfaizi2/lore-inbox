Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWEHGBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWEHGBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 02:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWEHGBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 02:01:42 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:64005 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S932323AbWEHGBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 02:01:41 -0400
Date: Mon, 08 May 2006 15:01:52 +0900 (JST)
Message-Id: <20060508.150152.113737945.yoshfuji@linux-ipv6.org>
To: jfritschi@freenet.de
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [RFC][PATCH 1/2] Twofish cipher i586-asm optimized
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200605072247.46655.jfritschi@freenet.de>
References: <200605071156.57844.jfritschi@freenet.de>
	<200605072247.46655.jfritschi@freenet.de>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200605072247.46655.jfritschi@freenet.de> (at Sun, 7 May 2006 22:47:46 +0200), Joachim Fritschi <jfritschi@freenet.de> says:

> After going over my patch again, i realized i missed the .cra_priority 
> and .cra_driver_name setting in the crypto api struct. Here is an updated 
> version of my patch:
> 
> http://homepages.tu-darmstadt.de/~fritschi/twofish/twofish-i586-asm-2.6.17-2.diff 

Any reasons to exclude 64BIT on Kconfig?

--yoshfuji
