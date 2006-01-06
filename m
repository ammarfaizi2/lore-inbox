Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWAFTSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWAFTSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbWAFTSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:18:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:60392 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751190AbWAFTSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:18:11 -0500
Date: Fri, 6 Jan 2006 20:17:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Dave Jones <davej@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: dual line backtraces for i386.
In-Reply-To: <200601061338_MC3-1-B567-4FDD@compuserve.com>
Message-ID: <Pine.LNX.4.61.0601062016550.28630@yvahk01.tjqt.qr>
References: <200601061338_MC3-1-B567-4FDD@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >                         printk(space == 0 ? "     " : "\n");
>> >                         space = !space;
>>
>> readability ?
>
>Well, if I were going for _un_readability I'd have suggested:
>
>        printk(space = !space ? "     " : "\n");

Anyone voting for "\t" instead of "     "?


Jan Engelhardt
-- 
