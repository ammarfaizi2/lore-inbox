Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266185AbUBLH6G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 02:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266285AbUBLH6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 02:58:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:18326 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266185AbUBLH6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 02:58:04 -0500
Subject: Re: PPC64 PowerMac G5 support available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402112234140.5816@home.osdl.org>
References: <1076563481.2285.167.camel@gaston>
	 <Pine.LNX.4.58.0402112223480.5816@home.osdl.org>
	 <Pine.LNX.4.58.0402112234140.5816@home.osdl.org>
Content-Type: text/plain
Message-Id: <1076572505.12556.205.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 18:55:05 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW. Please do:

bk rm include/asm-ppc64/offsets.h

This file is generated, it's plain wrong to distribute one and
could explain all sorts of strange things :)

(It contains the offsets into some kernel data structures to be
used by the asm code)

Andrew: If you have such a file in your tree, remove it from the
distribution too. I'll check if it's part of the make distclean
process, I'm afraid it may not...

Ben.


