Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263989AbTIIKPM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 06:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTIIKPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 06:15:12 -0400
Received: from mta204-rme.xtra.co.nz ([210.86.15.147]:29346 "EHLO
	mta204-rme.xtra.co.nz") by vger.kernel.org with ESMTP
	id S263989AbTIIKPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 06:15:07 -0400
Message-ID: <3F5E8A1F.2070904@tait.co.nz>
Date: Tue, 09 Sep 2003 22:19:11 -0400
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with remap_page_range
References: <3F5E7ACD.8040106@tait.co.nz> <20030909095926.GA31080@mail.jlokier.co.uk>
In-Reply-To: <20030909095926.GA31080@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Try io_remap_page_range() instead?
>  
>
I just tried - the problem remains, but what is interesting:

Correct values (driver):

dsp_area[0]=91ba
dsp_area[1]=bc00
dsp_area[2]=eb17
dsp_area[3]=2643
dsp_area[4]=54cd
dsp_area[5]=5405
dsp_area[6]=91ba
dsp_area[7]=49c2
dsp_area[8]=1f61

Wrong values (application):

kadr[0]=1c59
kadr[1]=5405
kadr[2]=1f61
kadr[3]=49c2
kadr[4]=49c2
kadr[5]=eb17
kadr[6]=1f61
kadr[7]=2643


It's looks like application has some correct values but it's kind of mess.
What else could be wrong?

Thank you very much

