Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265457AbTF1XFM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 19:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265456AbTF1XFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 19:05:12 -0400
Received: from host09.ipowerweb.com ([12.129.206.109]:39915 "EHLO
	host09.ipowerweb.com") by vger.kernel.org with ESMTP
	id S265460AbTF1XEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 19:04:49 -0400
Message-ID: <3EFE2231.2050707@libero.it>
Date: Sun, 29 Jun 2003 01:18:09 +0200
From: "Luca T." <luca-t@libero.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /dev/random broken?
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host09.ipowerweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
i am not sure if this is a kernel/module problem but so it seems to me.
My computer is an AMD 2000+ with an ABIT motherboard, my kernel version 
is 2.4.21-0.13mdk (but i tried it with 2.4.21-0.18mdk too and it doesn't 
work either).

If i give this command:
  dd if=/dev/zero of=./xxx bs=1024 count=100
it will work perfectly. But if i try to do the same reading from 
/dev/random with this command:
  dd if=/dev/random of=./xxx bs=1024 count=100
it will just sit there and stare at me until i move the mouse... and 
then the program will exit without any error message (i checked in 
/var/log/messages too and there is no message there either about this).

Is this a bug? If yes... do you have any idea that would help me fix it?

Thank you,
     Luca

