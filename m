Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbTAOEK2>; Tue, 14 Jan 2003 23:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTAOEK1>; Tue, 14 Jan 2003 23:10:27 -0500
Received: from blizzard.bluegravity.com ([64.57.64.28]:61458 "HELO
	blizzard.bgci.net") by vger.kernel.org with SMTP id <S261527AbTAOEK0>;
	Tue, 14 Jan 2003 23:10:26 -0500
Message-ID: <3E24E1B2.3050308@ryanflynn.com>
Date: Tue, 14 Jan 2003 23:21:06 -0500
From: ryan <ryan@ryanflynn.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.56 sound/oss/sb_mixer.c bounds check
References: <3E24D1D5.5090200@ryanflynn.com> <200301141930.00567.akpm@digeo.com>
In-Reply-To: <200301141930.00567.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yup.
> 
> It would be better to do:
> 
> 	if (dev < 0 || dev >= ARRAY_SIZE(smw_mix_regs))

yup, much better. i did a little housecleaning on the whole file, as 
well as 2 more bounds checks in appropriate places.

i'm sorry to ask, but i'm new -- i've got a ~500 line patch, and my 
email client is wrapping at 80 chars (unfortunately some lines run over 
80 chars), is sending an attachment in ascii format ok? i've seen some 
patches sent as attachments, not sure.

waiting for a yes/no response, please cc me

