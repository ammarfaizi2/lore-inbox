Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTAOE04>; Tue, 14 Jan 2003 23:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTAOE0z>; Tue, 14 Jan 2003 23:26:55 -0500
Received: from blizzard.bluegravity.com ([64.57.64.28]:1290 "HELO
	blizzard.bgci.net") by vger.kernel.org with SMTP id <S261290AbTAOE0z>;
	Tue, 14 Jan 2003 23:26:55 -0500
Message-ID: <3E24E591.1000805@ryanflynn.com>
Date: Tue, 14 Jan 2003 23:37:37 -0500
From: ryan <ryan@ryanflynn.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.56 sound/oss/sb_mixer.c bounds check
References: <3E24D1D5.5090200@ryanflynn.com> <200301141930.00567.akpm@digeo.com>
In-Reply-To: <200301141930.00567.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
--snip--
> It would be better to do:
> 
> 	if (dev < 0 || dev >= ARRAY_SIZE(smw_mix_regs))
> 

some bounds checking and general housecleaning

http://www.0x80.org/patches/2.5.56/sb_mixer.diff

