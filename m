Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268568AbUJDTff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268568AbUJDTff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268486AbUJDTch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:32:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52621 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268502AbUJDTYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:24:04 -0400
Message-ID: <4161A3BF.4020908@RedHat.com>
Date: Mon, 04 Oct 2004 15:25:51 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockd
References: <41617958.2020406@RedHat.com> <1096912231.22446.60.camel@lade.trondhjem.org>
In-Reply-To: <1096912231.22446.60.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Trond Myklebust wrote:

>På må , 04/10/2004 klokka 18:24, skreiv Steve Dickson:
>
>  
>
>>Hey Neil,
>>    
>>
>
>Hey! This is the client side NLM code... 8-)
>  
>
Sorry buddy.... I'm having one of those days!!!! :-\

>Note that you probably also want to move the call to
>set_current_state(TASK_INTERRUPTIBLE) inside the loop. In that case you
>can also remove the call to set_current_state(TASK_RUNNING) ('cos
>schedule_timeout() will do that for you).
>
>  
>
Ok...

>Also, why aren't you using the more standard DECLARE_WAITQUEUE(__wait)?
>  
>
I guess I didn't realize that would be a better way to do it... I'll 
look into to...

thanks,

SteveD.

