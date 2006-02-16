Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWBPDnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWBPDnd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWBPDnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:43:33 -0500
Received: from ozlabs.org ([203.10.76.45]:37047 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932224AbWBPDnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:43:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17395.62667.675949.112899@cargo.ozlabs.ibm.com>
Date: Thu, 16 Feb 2006 14:43:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Subject: Re: [PATCH] Provide an interface for getting the current tick length
In-Reply-To: <Pine.LNX.4.64.0602151926590.916@g5.osdl.org>
References: <17395.53939.795908.336324@cargo.ozlabs.ibm.com>
	<20060215173545.43a7412d.akpm@osdl.org>
	<17395.56186.238204.312647@cargo.ozlabs.ibm.com>
	<20060215180848.4556e501.akpm@osdl.org>
	<17395.59762.126398.423546@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0602151926590.916@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> And while at it, please make it much more readable by writing it as
> 
> 	time_adjust_step = time_adjust;
> 	if (time_adjust_step) {
> 		..
> 
> which is even less to type (no "!= 0", no extra parenthesis, just a 
> ";<nl><tab>", and you've saved a whopping three bytes of source code while 

... you've forgotten that now I've had to type "time_adjust_step"
twice. :P  Anyway, I don't mind changing it, if you think it's worth
pulling that little bit of code out into its own function.

Paul.
