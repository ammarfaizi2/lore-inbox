Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbUBDWsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 17:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbUBDWsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 17:48:33 -0500
Received: from mx1.mail.ru ([194.67.23.21]:14864 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S263771AbUBDWrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 17:47:47 -0500
Message-ID: <40217690.5070107@mail.ru>
Date: Wed, 04 Feb 2004 17:47:44 -0500
From: Yaroslav Klyukin <skintwin@mail.ru>
User-Agent: Mozilla/5.0 (http://klyukin.com/)
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: aacraid, opteron, over 1G memory....
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aacraid does not seem to initialize if there is above 1-2 gigs of memory.
If I boot with mem=1000M , it works.
I tried to change the comminit.c file in the aacraid directory and 
played with the memory values, but it looks like it does not make a 
difference.
I am using 2.6.2 kernel.

If anybody knows anything about the issue, please let me know, because 
it is listed as solved on RedHat's bugzilla site and on other sites, 
which I visited, but it does not work still.

BTW the lower version kernel does not work either (2.6.1 with x86_64.org 
patches).




