Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVFUUfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVFUUfC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVFUUd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:33:26 -0400
Received: from zamok.crans.org ([138.231.136.6]:54410 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261424AbVFUUac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:30:32 -0400
Message-ID: <42B878DD.9000504@crans.org>
Date: Tue, 21 Jun 2005 22:30:21 +0200
From: =?ISO-8859-15?Q?Mathieu_B=E9rard?= <Mathieu.Berard@crans.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1  irq 21: nobody cared with snd_via82xx
References: <42B73C04.1010301@crans.org> <200506211003.44419.bjorn.helgaas@hp.com>
In-Reply-To: <200506211003.44419.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas a écrit :

>On Monday 20 June 2005 3:58 pm, Mathieu Bérard wrote:
>  
>
>>I get this while booting linux 2.6.12-mm1 (+ bridge conntrack fix BTW) 
>>with a VIA integrated audio ship.
>>
>>It worked well at least under 2.6.11-mm1.
>>    
>>
>
>Sigh.  Can you reverse the attached patch (apply it with -R)
>and see whether it helps?  VIA IRQs are a never-ending headache.
>
>  
>
Well, it does !
All IRQ related error messages are gone with that path reversed.

Thanks.

-- 
Mathieu Berard

