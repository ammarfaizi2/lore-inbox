Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVCGNPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVCGNPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 08:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVCGNPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 08:15:48 -0500
Received: from av9-1-sn3.vrr.skanova.net ([81.228.9.185]:50126 "EHLO
	av9-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261155AbVCGNPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 08:15:43 -0500
Message-ID: <422C539A.4040407@fulhack.info>
Date: Mon, 07 Mar 2005 14:14:02 +0100
From: Henrik Persson <root@fulhack.info>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor@mail.ru
Cc: linux-kernel@vger.kernel.org
Subject: Touchpad "tapping" changes in 2.6.11?
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

I noticed that the ALPS driver was added to 2.6.11, a thing that alot of 
people probably like, but since my touchpad (Acer Aspire 1300XV) worked 
perfectly before (like, 2.6.10) and now the ALPS driver disables 
'hardware tapping', wich makes it hard to tap. I commented out the 
disable-tapping bits in alps.c and now it's working like a charm again.

Maybe the hardware tapping-thing should be configurable via some boot or 
config option?

-- 
Henrik Persson
