Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUHBGCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUHBGCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 02:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUHBGCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 02:02:20 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:19972 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S266289AbUHBGA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 02:00:56 -0400
Message-ID: <410DD932.6040204@kolumbus.fi>
Date: Mon, 02 Aug 2004 09:03:30 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@digitalimplant.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [6/25] Merge pmdisk and swsusp
References: <Pine.LNX.4.50.0407171528280.22290-100000@monsoon.he.net> <20040718220954.GB31958@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.50.0408012018370.30101-100000@monsoon.he.net> <410DCB45.7060407@kolumbus.fi> <Pine.LNX.4.50.0408012208300.8159-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0408012208300.8159-100000@monsoon.he.net>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 02.08.2004 09:03:55,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 02.08.2004 09:02:45,
	Serialize complete at 02.08.2004 09:02:45
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patrick Mochel wrote:

>On Mon, 2 Aug 2004, [ISO-8859-1] Mika Penttil? wrote:
>
>  
>
>>Why alloc twice for the saved pages, once in calc_order() and then in
>>alloc_image_pages() ?
>>    
>>
>
>There is only one allocation each for both the pagedir (in
>alloc_pagedir()) and the image pages (in alloc_image_pages()). So, I'm not
>sure what you mean..
>
>Thanks,
>
>
>	Pat
>-
>  
>

Ah ok. It was the alloc pagedir space for the pagedir pages itself that 
confused me. This part was missing from swsusp before, I think.

--Mika


