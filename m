Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbTJJAFM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 20:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbTJJAFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 20:05:12 -0400
Received: from dyn-ctb-203-221-72-16.webone.com.au ([203.221.72.16]:14340 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262676AbTJJAFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 20:05:08 -0400
Message-ID: <3F85F7A1.1070904@cyberone.com.au>
Date: Fri, 10 Oct 2003 10:04:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Dual Xeon 2.6GHz, Supermicro X5DPA-TGM (SerialATA): 2.4.x causes
 system pauses, 2.6.0-test6 works fine
References: <20031007181339.GB1239@boom.net> <bm4ev7$5u7$1@gatekeeper.tmr.com>
In-Reply-To: <bm4ev7$5u7$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



bill davidsen wrote:

>In article <20031007181339.GB1239@boom.net>,
>Taner Halicioglu  <taner@taner.net> wrote:
>
>| Hi, I just built a new system and under all the 2.4.x kernels I tried (latest
>| redhat, and stock 2.4.22 as well) I would have 10-20s system pauses during
>| stress testing (a simple kernel compile loop, using make -j4) - appeared to
>| be disk subsystem, as I could change windows in screen, and network was
>| working fine.  I tried several APIC and ACPI settings to no avail.  I tried
>| disabling Hyperthreading - no dice.  I tried running a UP kernel - no dice.
>| 
>| Upon installing the 2.6.0-test6 kernel, the pauses were gone!  (for the most
>| part... have an occasional 2s pause, but that is considerably better than
>| 10-20s ;))
>
>Try booting with elevator=deadline, see if the last pause goes away.
>

Or try running the compile completely out of tmpfs. That should mostly take
the disk and virtual memroy subsystems out of the picture.


