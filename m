Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVILVlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVILVlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVILVlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:41:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11981
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932270AbVILVlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:41:03 -0400
Date: Mon, 12 Sep 2005 14:41:07 -0700 (PDT)
Message-Id: <20050912.144107.37064900.davem@davemloft.net>
To: joebob@spamtest.viacore.net
Cc: cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4325F3D5.9040109@spamtest.viacore.net>
References: <43229BA4.4010306@pobox.com>
	<20050910163446.GA2232@taniwha.stupidest.org>
	<4325F3D5.9040109@spamtest.viacore.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Bob Spamtest <joebob@spamtest.viacore.net>
Date: Mon, 12 Sep 2005 14:32:05 -0700

> Chris Wedgwood wrote:
> >> /lib64 is an awful scheme.  I'd avoid it.
> > I'd like to see people move away from it before it gets too entrenched
> > too.
> 
> agreed -- as far as i'm concerned the 32 bit libraries are there for 
> compatibility's sake and should be in /lib/compat/<subarch> instead of 
> /lib. the native libraries should be in /lib instead of /lib64. lib64 
> should just go away!

64-bit isn't any more "native" than 32-bit on some 64-bit platforms.
32-bit is the default and most desirable userland binary format on
sparc64 for example.  So 32-bit programs on sparc64 are as "native" as
64-bit ones might be considered.
