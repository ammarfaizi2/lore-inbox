Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVFKRxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVFKRxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVFKRxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:53:37 -0400
Received: from mail-gw.turkuamk.fi ([195.148.208.32]:53904 "EHLO
	mail-gw.turkuamk.fi") by vger.kernel.org with ESMTP id S261757AbVFKRxf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:53:35 -0400
Message-ID: <42AB2589.4010502@kolumbus.fi>
Date: Sat, 11 Jun 2005 20:55:21 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
References: <Pine.LNX.4.10.10506111029290.27294-100000@godzilla.mvista.com>
In-Reply-To: <Pine.LNX.4.10.10506111029290.27294-100000@godzilla.mvista.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.13a
  |April 8, 2004) at 11.06.2005 20:53:33,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4|March
 27, 2005) at 11.06.2005 20:53:33,
	Serialize complete at 11.06.2005 20:53:33
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:

>On Sat, 11 Jun 2005, [UTF-8] Mika Penttilä wrote:
>
>  
>
>>ok, so maybe the safe way is to enforce threaded softirq with the soft 
>>irq flag.
>>
>>    
>>
>
>That's already handled, my changes are used only when you turn on
>PREEMPT_RT , and PREEMPT_RT forces softirq threading.
>
>Daniel
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Ok, so everything's fine :)

Thanks,
--Mika


