Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263565AbUFFM5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUFFM5y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 08:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUFFM5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 08:57:54 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:19344 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S263565AbUFFM5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 08:57:50 -0400
Message-ID: <40C314C4.4080006@dlfp.org>
Date: Sun, 06 Jun 2004 14:57:40 +0200
From: Benoit Dejean <TazForEver@dlfp.org>
Reply-To: TazForEver@free.fr
User-Agent: Mozilla Thunderbird 0.6 (X11/20040528)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: cyplp@free.fr
Subject: [2.6.6 panic] via-rhine and acpi sleep 3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello, i'm getting troubles with my epia boxes : epia via motherboard + 
C3 processor.

the acpi STR sleep works fine (the CPU fan goes down) and wake up is ok. 
But, i'm experiencing bugs with the builtin via-rhine network card. on 
wake up, the network card seems to have been not correctly suspended : 
it doesn't work anymore. i tried to find a way with acpi so that the 
network interface is downed before sleep, the module unloaded and vice 
versa on wake up. but that doesn't work.

on wake up, trying to re-activate my netcard, i often get some message 
obout ill-formed ethernet frames. i also often get kernel panic but i've 
not been able to save the kernel panic trace. i don't know how, so if 
somebody could tell me how to save it ...

regards,
Benoit
