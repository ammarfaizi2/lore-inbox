Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267895AbUHKCyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267895AbUHKCyE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 22:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267896AbUHKCyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 22:54:04 -0400
Received: from Jupiter.Toms.NET ([64.32.223.162]:16064 "EHLO jupiter.toms.net")
	by vger.kernel.org with ESMTP id S267895AbUHKCyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 22:54:02 -0400
Date: Tue, 10 Aug 2004 22:54:00 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
To: linux-kernel@vger.kernel.org
Subject: minix fs problem in 2.6
Message-ID: <Pine.LNX.4.58.0408102250220.502@jupiter.toms.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The minix fs has something different in kernel 2.6 such that "du" fails badly.

du is returning quantities that are approximately 1/4th of what is correct.

It was working fine in 2.4.

I'm not sure if anyone but me still cares...

Tomsrtbt creates filesystem sizes on ramdisks throughout its build that are
calculated from du results to build things just big enough without waste.

It seems to not be buildable on 2.6.

-Tom

