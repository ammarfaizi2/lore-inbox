Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132583AbRDBAj2>; Sun, 1 Apr 2001 20:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132590AbRDBAjS>; Sun, 1 Apr 2001 20:39:18 -0400
Received: from james.kalifornia.com ([208.179.59.2]:60725 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S132583AbRDBAjI>; Sun, 1 Apr 2001 20:39:08 -0400
Message-ID: <3AC7C719.3080403@kalifornia.com>
Date: Sun, 01 Apr 2001 17:26:01 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <dlang@diginsite.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
   Manfred Spraul <manfred@colorfullife.com>,
   "Albert D. Cahalan" <acahalan@cs.uml.edu>, lm@bitmover.com,
   linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.4.33.0104011640280.25794-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not have the /proc/config option but instead of being plain text, 
make it binary with a userspace app that can interpret it?

It could have a signature as to kernel version + patches and the rest 
would be just bits.

Instead of:

CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

You'd have
2.4.3-pre3:1101111100000100000000 . . . . .

-b

