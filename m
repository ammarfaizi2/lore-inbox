Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130399AbRCIBEP>; Thu, 8 Mar 2001 20:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130406AbRCIBD4>; Thu, 8 Mar 2001 20:03:56 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:39689 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S130399AbRCIBDt>;
	Thu, 8 Mar 2001 20:03:49 -0500
Message-ID: <3AA82C12.3000204@megapathdsl.net>
Date: Thu, 08 Mar 2001 17:04:18 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac5 i686; en-US; m18) Gecko/20010207
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-ac15 -- Build fails in serial.c if CONFIG_SERIAL_CONSOLE is enabled.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In serial.c, in function `wait_for_xmitr' at lines 5497 and 5666, 
`ASYNC_NO_FLOW' is undeclared.

