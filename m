Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268730AbUHTUfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbUHTUfG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268727AbUHTUcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:32:17 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:39123 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S264973AbUHTUbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:31:37 -0400
Message-ID: <4126600F.4050302@drzeus.cx>
Date: Fri, 20 Aug 2004 22:33:19 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Timer allocates too many ports
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The timer in linux allocates the io ports 0x40 to 0x5F. This is causing 
some problems for me since the hardware I'm writing a driver for has its 
ports at 0x4E and 0x4F. In Windows the ports 0x40 to 0x43 are used for 
the timer. Why does linux allocate so many more ports?

Rgds
Pierre Ossman

