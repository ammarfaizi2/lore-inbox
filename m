Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWCJDZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWCJDZu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 22:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWCJDZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 22:25:49 -0500
Received: from wb1-a.mail.utexas.edu ([128.83.126.134]:55570 "EHLO
	wb1-a.mail.utexas.edu") by vger.kernel.org with ESMTP
	id S932133AbWCJDZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 22:25:49 -0500
Message-ID: <4410F1B7.80302@mail.utexas.edu>
Date: Thu, 09 Mar 2006 19:25:43 -0800
From: Philip Langdale <philipl@mail.utexas.edu>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: bjdouma@xs4all.nl, linux-kernel@vger.kernel.org
CC: gregkh@suse.de
Subject: pci-pci-quirk-for-asus-a8v-and-a8v-deluxe-motherboards.patch
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Saw this patch mentioned in passing and I wanted to point out
that this is a more general problem than just for asus motherboards.
I have a soyo kt880 based dragon 2 motherboard and it exhibits the
same behaviour and the same fix works (modulo looking for a different
subsystem vendor - soyo apparently don't have their own id - it's
set to VIA for all devices). And I've read about it affecting other
motherboards - I think it must be something that's present in the
reference BIOS that all the manufacturers use.

I'm not sure what the most efficient way to generalise it - especially
with cases like the Soyo one where there's no proper subvendor id.

--phil
