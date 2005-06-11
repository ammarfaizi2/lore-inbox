Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVFKRbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVFKRbK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVFKR2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:28:49 -0400
Received: from mail-gw.turkuamk.fi ([195.148.208.32]:26511 "EHLO
	mail-gw.turkuamk.fi") by vger.kernel.org with ESMTP id S261752AbVFKR2D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:28:03 -0400
Message-ID: <42AB1F8D.30104@kolumbus.fi>
Date: Sat, 11 Jun 2005 20:29:49 +0300
From: =?UTF-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
References: <Pine.LNX.4.10.10506111024460.27294-100000@godzilla.mvista.com>
In-Reply-To: <Pine.LNX.4.10.10506111024460.27294-100000@godzilla.mvista.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.13a
  |April 8, 2004) at 11.06.2005 20:28:01,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4|March
 27, 2005) at 11.06.2005 20:28:02,
	Serialize complete at 11.06.2005 20:28:02
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:

>On Sat, 11 Jun 2005, [ISO-8859-15] Mika Penttil� wrote:
>  
>
>>Not with !softirq_preemption, then we take the immediate path and 
>>process soft irqs on irq exit.
>>    
>>
>
>My changes aren't used in that case.
>
>Daniel
>
>
>  
>
ok, so maybe the safe way is to enforce threaded softirq with the soft 
irq flag.

--Mika


