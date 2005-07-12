Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVGLEyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVGLEyi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 00:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVGLEyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 00:54:38 -0400
Received: from hera.kernel.org ([209.128.68.125]:16333 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262357AbVGLEyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 00:54:37 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: zImage on 2.6?
Date: Tue, 12 Jul 2005 04:54:16 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <davido$8cl$1@terminus.zytor.com>
References: <20050503012951.GA10459@animx.eu.org> <20050503072626.3a3c7349.rddunlap@osdl.org> <20050503163343.GC11937@animx.eu.org> <20050503095913.1c9b62ba.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1121144056 8598 127.0.0.1 (12 Jul 2005 04:54:16 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 12 Jul 2005 04:54:16 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050503095913.1c9b62ba.rddunlap@osdl.org>
By author:    "Randy.Dunlap" <rddunlap@osdl.org>
In newsgroup: linux.dev.kernel
> | 
> | Yes, I do recall it says "System is 724k".  zImage failes.  bzImage says
> | 724k as well and succeeds.
> 
> The image size needs to be <= 0x7f000 (520192 bytes, 508 KB).
> 
> (No, I don't know why, just that this is what is being
> enforced.)
> 

Because that's the size of the hole that a zImage has to fit inside.

WTF is someone using zImage still?

    -hpa
