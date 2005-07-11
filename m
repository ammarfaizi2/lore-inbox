Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVGKIT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVGKIT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 04:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVGKIT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 04:19:28 -0400
Received: from [195.144.244.147] ([195.144.244.147]:7404 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S261323AbVGKIT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 04:19:27 -0400
Message-ID: <42D22B8C.4020403@varma-el.com>
Date: Mon, 11 Jul 2005 12:19:24 +0400
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hwd accel framebuffer: Newbi question (sleep in sync)
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Anyone could explain me, could I or couldn't
use process sleep (i.e. wait_for..., sleep_on...)
in fb_info->fb_sync and/or in any hwd accelerated routines (i.e. blit,
cursor and rectfill)?
Code, which now in kernel, look terrible for me (counter based pooling).
Must it be so?

-- 
Regards
Andrey Volkov
