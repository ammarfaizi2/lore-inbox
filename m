Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbUAEOng (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 09:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbUAEOng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 09:43:36 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:2979 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264485AbUAEOne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 09:43:34 -0500
Subject: kernel-2.6.1-rc1-bk6: too many northbridges for AGP
From: detlef.grittner@t-online.de (Detlef Grittner)
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1073313905.6180.10.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 05 Jan 2004 15:45:05 +0100
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: SsV6loZ6ZeDqTOYfpZ8qdaf9S1p34yKFC4ujslfQHQ3ztUhoaBrUQG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have compiled and installed the kernel-2.6.1-rc1-bk6 on a x32_64
architecture, i.e. an AMD Athlon64 3200+ processor.
In the dmesg I can see the following messages:

agpgart: Detected AGP bridge 0
agpgart: Too many northbridges for AGP

And AGP doesn't work after this. The northbridge chipset is a VIA K8T800
(southbridge is VT8237). The video card is an NVidia 5900 with AGP8x.

I think I've read in the NVidia newsgroup that this is a known bug and
would be fixed in 2.6.0, but now I'm not sure: Is this a known bug or is
it a new bug?

Detlef



