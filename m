Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbTHTNyU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 09:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTHTNyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 09:54:20 -0400
Received: from [62.13.18.67] ([62.13.18.67]:31425 "EHLO
	mail.kontorshotellet.nu") by vger.kernel.org with ESMTP
	id S261949AbTHTNyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 09:54:19 -0400
Message-ID: <3F437D8A.3040409@lanil.mine.nu>
Date: Wed, 20 Aug 2003 15:54:18 +0200
From: Christian Axelsson <smiler@lanil.mine.nu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030814 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: "Bryan D. Stine" <admin@kentonet.net>, linux-kernel@vger.kernel.org
Subject: Re: DVD ROM on 2.6
References: <20030819193456.B25148@animx.eu.org> <200308192003.22182.admin@kentonet.net> <20030819202108.A25325@animx.eu.org>
In-Reply-To: <20030819202108.A25325@animx.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:

>>Try passing the -t iso9660 option to mount or (if that doesn't work) you could 
>>go so far as to removing the UDF support from the kernel.
>>    
>>
>
>I had a brain fart.  I was using -o instead of -t =(
>
>I do have DVDs playing now on 2.6.0-test3.  I used ide-cd instead of
>ide-scsi.  apparently the scsi layer didn't like it.
>Buffer I/O error on device sr1, logical block 7651
>Buffer I/O error on device sr1, logical block 7652
>Buffer I/O error on device sr1, logical block 7653
>end_request: I/O error, dev sr1, sector 660400
>
>I would get tons of Buffer I/O errors and some end_requests like the above
>  
>
I thought ide-scsi was broken?

--
Christian Axelsson
smiler@lanil.mine.nu


