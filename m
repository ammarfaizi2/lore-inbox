Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264169AbTDPAN3 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 20:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264170AbTDPAN3 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 20:13:29 -0400
Received: from palrel13.hp.com ([156.153.255.238]:25772 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264169AbTDPAN3 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 20:13:29 -0400
Date: Tue, 15 Apr 2003 17:25:05 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200304160025.h3G0P52i009908@napali.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: size of CRCs in module versions
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the point of using "unsigned long" for storing module version
CRCs?  As far as I can see, the CRCs are 32 bits in size, so using u32
would be more appropriate (and would avoid wasting space on 64-bit
platforms).

	--david
