Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278886AbRKFJMx>; Tue, 6 Nov 2001 04:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278961AbRKFJMp>; Tue, 6 Nov 2001 04:12:45 -0500
Received: from bs1.dnx.de ([213.252.143.130]:58559 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S278701AbRKFJMf> convert rfc822-to-8bit;
	Tue, 6 Nov 2001 04:12:35 -0500
Date: Tue, 6 Nov 2001 10:11:43 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: <linux-kernel@vger.kernel.org>
Subject: ioport range of 8259 aka pic1
Message-ID: <Pine.LNX.4.33.0111061001351.12441-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there a reason why the kernel (tested with 2.4.13) picks up the io port
region from 0020-003f for pic1? All I could find on the net lets me assume
that only 0020-0021 are used by the interrupt controllers (may be wrong
here - hints for literature are welcome). Same problem with pic2.

I'm currently working with an AMD Elan SC410 (x86 embedded system on chip)
which has it's private registers at 0022 and following, which makes it
impossible to write "correct" drivers that request_region() their ports
before using them.

Robert
-- 
 +--------------------------------------------------------+
 |             Dipl.-Ing. Robert Schwebel                 |
 | Pengutronix - Linux Solutions for Science and Industry |
 |  Braunschweiger Straﬂe 79, 31134 Hildesheim, Germany   |
 |     Phone: +49-5121-28619-0  Fax: +49-5121-28619-4     |
 +--------------------------------------------------------+

