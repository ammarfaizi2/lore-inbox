Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266262AbUFUPSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266262AbUFUPSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 11:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbUFUPSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 11:18:53 -0400
Received: from [203.178.140.15] ([203.178.140.15]:59142 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S266261AbUFUPSq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 11:18:46 -0400
Date: Tue, 22 Jun 2004 00:19:42 +0900 (JST)
Message-Id: <20040622.001942.89290875.yoshfuji@linux-ipv6.org>
To: yoda@isr.ist.utl.pt
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: kernel oops with v2.6.7 and tracepath6
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <m3zn6xdk38.fsf@pixie.isrnet>
References: <m3zn6xdk38.fsf@pixie.isrnet>
Organization: USAGI Project
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

In article <m3zn6xdk38.fsf@pixie.isrnet> (at Mon, 21 Jun 2004 16:08:59 +0100), Rodrigo Ventura <yoda@isr.ist.utl.pt> says:

> 
> Hello, I just got a kernel oops (two actually) after runmning
> tracepath6 (from suse's iputils-ss021109-147.rpm) in a suse9.1-i386
> machine:
:
>  [<c02e36cf>] ip6_output2+0x2af/0x2e0
>  [<c02e36db>] ip6_output2+0x2bb/0x2e0
>  [<c02e36cf>] ip6_output2+0x2af/0x2e0
>  [<c0104bd5>] error_code+0x2d/0x38
>  [<c02e4679>] ip6_fragment+0x359/0x8b0
>  [<c01fa25e>] csum_partial_copy_generic+0x3a/0xfc
>  [<c02e3734>] ip6_output+0x34/0x50
>  [<c02e3420>] ip6_output2+0x0/0x2e0
>  [<c02e5799>] ip6_push_pending_frames+0x289/0x440

Already fixed in current bk tree.
Thanks.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
