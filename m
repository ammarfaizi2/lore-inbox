Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVLTUEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVLTUEB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbVLTUEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:04:00 -0500
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:3760 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750959AbVLTUEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:04:00 -0500
Message-ID: <BAYC1-PASMTP05C8DBAD89766601B44334AE3E0@CEZ.ICE>
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <58575.10.10.10.28.1135109038.squirrel@linux1>
In-Reply-To: <122020051953.9002.43A861470004E9E70000232A220702095300009A9B9CD3040A0
     29D0A05@comcast.net>
References: <122020051953.9002.43A861470004E9E70000232A220702095300009A9B9CD3040A029D0A05@comcast.net>
Date: Tue, 20 Dec 2005 15:03:58 -0500 (EST)
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: "Sean" <seanlkml@sympatico.ca>
To: "Parag Warudkar" <kernel-stuff@comcast.net>
Cc: "David Lang" <dlang@digitalinsight.com>,
       "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Dumitru Ciobarcianu" <dumitru.ciobarcianu@ines.ro>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>,
       "Andi Kleen" <ak@suse.de>, "Adrian Bunk" <bunk@stusta.de>,
       "Kyle Moffett" <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 20 Dec 2005 20:03:59.0721 (UTC) FILETIME=[842EE590:01C605A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, December 20, 2005 2:53 pm, Parag Warudkar said:

> Why take away the 8K option which already exists and works for people who
> need it? Let people choose what suits their needs. Forcing 4K stacks on
> people and asking them to sacrifice functionality while *gaining nothing*
> - sure sounds illogical. (You gain from 4K stacks - you have it as
> default, but technically you gain NOTHING from taking away the 8k option.)

Listen, for anyone who "needs" 8K stacks they can maintain the patch
themselves, they don't need it in the mainline kernel.   One of the points
of removing the 8K stack option is to singal to vendors and everyone else
that bugs arising from using 8K stacks and ** ANY ** sloppy code that
_needs_ 8K stacks is no longer appropriate for mainline.  The kernel
doesn't just carry around a bunch of crappy options because someone
somewhere thinks he needs it.

Sean

