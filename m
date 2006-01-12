Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWALHsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWALHsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 02:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWALHsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 02:48:46 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:41743 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S932115AbWALHsp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 02:48:45 -0500
Date: Thu, 12 Jan 2006 16:49:32 +0900 (JST)
Message-Id: <20060112.164932.55192618.yoshfuji@linux-ipv6.org>
To: ahessling@gmx.de
Cc: linux-kernel@vger.kernel.org, CHINEN@jp.ibm.com, usagi-core@linux-ipv6.org
Subject: Re: Kernel 2.6.15 sometimes only detects one of two SATA drives
 and panics
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1137003241.7603.20.camel@localhost.localdomain>
References: <1137003241.7603.20.camel@localhost.localdomain>
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

In article <1137003241.7603.20.camel@localhost.localdomain> (at Wed, 11 Jan 2006 19:14:01 +0100), Andre Hessling <ahessling@gmx.de> says:

> I recently upgraded from 2.6.14 to 2.6.15 vanilla and I encountered some
> random kernel panics on boot so far.
> 
> The panic is:
> "Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)"

We observe similar problem.
And the problem seems to go away if we turned off CONFIG_SMP.

--yoshfuji
