Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266981AbUAXSIw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 13:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266982AbUAXSIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 13:08:52 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:45581 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S266981AbUAXSIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 13:08:51 -0500
Date: Sat, 24 Jan 2004 19:10:27 +0100
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: Request: I/O request recording
Message-ID: <20040124181026.GA22100@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to have a user space program that I could run while I cold
start KDE.  The program would then record which I/O pages were read in
which order.  The output of that program could then be used to pre-cache
all those pages, but in an order that reduces disk head movement.
Demand Loading unfortunately produces lots of random page I/O scattered
all over the disk.

Having a way to know which pages are accessed in which order at a
typical cold start would be very benefitial, not only for the purpose
described above but it could also be used as input for a linker code
reordering optimization.

What do you think?

Felix
