Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUALTbz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 14:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbUALTbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 14:31:55 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:51020 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S264936AbUALTby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 14:31:54 -0500
Message-ID: <4002F627.8000508@samwel.tk>
Date: Mon, 12 Jan 2004 20:31:51 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Krueger <kai.a.krueger@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
References: <200401121707.i0CH7iQ11796@mailgate5.cinetic.de>
In-Reply-To: <200401121707.i0CH7iQ11796@mailgate5.cinetic.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Krueger wrote:
> I'm currently trying kernel 2.6.1-mm1 with laptop-mode on a reiserfs partition.
> If I kill all daemons running on the system and do nothing with it, I can achieve the 10 minutes spin down time I had expected from laptop-mode. However as soon as I start up X with KDE I get regular spin ups every 30 seconds. Looking at the output of "echo 1 > /proc/sys/vm/block_dump", I see an entry every 30 seconds of "kdeinit(15145): WRITE block 65680 on hda1" followed by a whole load of "reiserfs/0(12): dirtied page" and "reisers/0(12): WRITE block XXXXX on hda1".
> 
> Due to the regular 30 second interval writes of kdeinit: kded to block 65680, laptop-mode is not particularly usable on this system.
> Is this a problem with reiserfs or with kde and is there any fix available?

Can you take a look at the message that Dumitru Ciobarcianu just sent to 
the list (about syslog), and check if it's that?

-- Bart
