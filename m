Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUAFJG6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 04:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUAFJG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 04:06:58 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:12808 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S261575AbUAFJGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 04:06:55 -0500
Message-ID: <3FFA7BB9.1030803@kolumbus.fi>
Date: Tue, 06 Jan 2004 11:11:21 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@colin2.muc.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de> <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de>
In-Reply-To: <20040106081203.GA44540@colin2.muc.de>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 06.01.2004 11:09:00,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 06.01.2004 11:08:09,
	Serialize complete at 06.01.2004 11:08:09
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi Kleen wrote:

>>If you ahve a proper e820 map, then it should work correctly, with 
>>anything that is RAM being marked as such (or being marked as "reserved").
>>    
>>
>
>Every e820 map i've seen did not have the AGP aperture marked reserved.
>
Why should it? It's not ram, and the aperture is marked as reserved 
while doing PCI resource assignment/reservation.

>It is just an undescribed hole.  In fact when you mark the aperture in the
>e820 map the Linux AGP driver stops working, it relies on it being
>in an undescribed hole.
>
>  
>


