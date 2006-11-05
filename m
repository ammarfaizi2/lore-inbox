Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422690AbWKEV20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422690AbWKEV20 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 16:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbWKEV20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 16:28:26 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:36788 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1422679AbWKEV2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 16:28:25 -0500
Message-ID: <454E575B.40403@keyaccess.nl>
Date: Sun, 05 Nov 2006 22:27:55 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Kyle Moffett <mrmacman_g4@mac.com>,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Albert Cahalan <acahalan@gmail.com>, kangur@polcom.net,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com> <Pine.LNX.4.64.0611050034480.26021@artax.karlin.mff.cuni.cz> <AA4E0826-81F3-47AF-8C5E-D691BB02AB32@mac.com> <454E48D9.3060303@zytor.com>
In-Reply-To: <454E48D9.3060303@zytor.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

[ partitions ]

> Actually, DOS/Win9x should handle arbitrary alignment just fine

For primary (and extended) partitions, yes. I haven't used any version 
of DOS that has ever objected to arbitrarily aligned partitions in the 
MBR (and I do align them arbitrarily since I always make my partitions 
some exact size and start the next partition in the next sector).

Different though for logical partitions inside an extended. As late as 
Windows 98, DOS would object to non-aligned logicals, at the very least 
with some settings for the BIOS use/don't use LBA or "Large" settings.

Linux doesn't care; I've used type 0x85 instead of 0x05 for my extended 
partitions dus to that for years. DOS just ignores that one...

Rene

