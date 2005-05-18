Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVERBTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVERBTv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 21:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVERBTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 21:19:51 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:12437 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262049AbVERBTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 21:19:37 -0400
X-ORBL: [63.205.185.30]
Date: Tue, 17 May 2005 18:19:30 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "Gilbert, John" <JGG@dolby.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
Message-ID: <20050518011930.GA30885@taniwha.stupidest.org>
References: <2692A548B75777458914AC89297DD7DA08B0866D@bronze.dolby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2692A548B75777458914AC89297DD7DA08B0866D@bronze.dolby.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 05:51:36PM -0700, Gilbert, John wrote:

> The use of "new" as a variable name in the macro "__cmpxchg" breaks
> builds of other programs that link to include/asm-i386/system.h I'd
> like to request that this be renamed to something else, like mynew
> or krnew.

there are plenty of similar examples where tokens used are reserved
words in c++ --- it's quite a lot of invasive work to clean these up
properly for little or no apparent gain
