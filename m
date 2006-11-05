Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbWKEVvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWKEVvm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 16:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbWKEVvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 16:51:41 -0500
Received: from terminus.zytor.com ([192.83.249.54]:58496 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1422717AbWKEVvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 16:51:41 -0500
Message-ID: <454E5CDC.7000002@zytor.com>
Date: Sun, 05 Nov 2006 13:51:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Rene Herman <rene.herman@keyaccess.nl>
CC: Kyle Moffett <mrmacman_g4@mac.com>,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Albert Cahalan <acahalan@gmail.com>, kangur@polcom.net,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com> <Pine.LNX.4.64.0611050034480.26021@artax.karlin.mff.cuni.cz> <AA4E0826-81F3-47AF-8C5E-D691BB02AB32@mac.com> <454E48D9.3060303@zytor.com> <454E575B.40403@keyaccess.nl>
In-Reply-To: <454E575B.40403@keyaccess.nl>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> H. Peter Anvin wrote:
> 
> [ partitions ]
> 
>> Actually, DOS/Win9x should handle arbitrary alignment just fine
> 
> For primary (and extended) partitions, yes. I haven't used any version 
> of DOS that has ever objected to arbitrarily aligned partitions in the 
> MBR (and I do align them arbitrarily since I always make my partitions 
> some exact size and start the next partition in the next sector).
> 
> Different though for logical partitions inside an extended. As late as 
> Windows 98, DOS would object to non-aligned logicals, at the very least 
> with some settings for the BIOS use/don't use LBA or "Large" settings.
> 
> Linux doesn't care; I've used type 0x85 instead of 0x05 for my extended 
> partitions dus to that for years. DOS just ignores that one...
> 

DOS, or FDISK?

	-hpa
