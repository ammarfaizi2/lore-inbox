Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVCaGZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVCaGZD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 01:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVCaGZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 01:25:02 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:50827 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262503AbVCaGYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 01:24:10 -0500
Date: Thu, 31 Mar 2005 08:23:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Malone <dwmalone@maths.tcd.ie>
cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Directory link count wrapping on Linux/XFS/i386?
In-Reply-To: <200503302043.aa27223@salmon.maths.tcd.ie>
Message-ID: <Pine.LNX.4.61.0503310822590.9253@yvahk01.tjqt.qr>
References: <200503302043.aa27223@salmon.maths.tcd.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>but it does let you can hide files from find/fts, as demonstrated
>below.

That's because `find` optimizes its searching by looking at the link count.
IIRC, the -noleaf option should make it visible again.

>turing 7% mkdir .hidden
>turing 8% touch .hidden/secret
>turing 9% find . -name secret -print



Jan Engelhardt
-- 
No TOFU for me, please.
