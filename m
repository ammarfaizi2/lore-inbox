Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbUCLOa1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 09:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbUCLOa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 09:30:26 -0500
Received: from smtp.irisa.fr ([131.254.130.26]:15760 "EHLO smtp.irisa.fr")
	by vger.kernel.org with ESMTP id S262139AbUCLOaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 09:30:15 -0500
Message-ID: <4051C976.3060808@irisa.fr>
Date: Fri, 12 Mar 2004 15:30:14 +0100
From: David Fort <david.fort@irisa.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040216
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unkillable Zombie process under 2.6.3 and 2.6.4
References: <40508D65.9000601@irisa.fr> <20040311151729.57e3d936.akpm@osdl.org> <4051C126.5080902@irisa.fr> <200403121506.18236.kernel@borntraeger.net>
In-Reply-To: <200403121506.18236.kernel@borntraeger.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Borntraeger wrote:

>David Fort wrote:
>  
>
>>I'm trying to build a test app that can trigger the case where GDBed
>>process become unkillable zombies
>>    
>>
>
>Does it help to send a SIGCONT to all processes in T state?
>
>  
>
No it doesn't, gdb loose its context when doing this(this triggers an 
internal gdb error):

lin-lwp.c:653: internal-error: stop_wait_callback: Assertion `pid == 
GET_LWP (lp->ptid)' failed.
A problem internal to GDB has been detected,
further debugging may prove unreliable.


Cheers

-- 
Fort David, Projet IDsA
IRISA-INRIA, Campus de Beaulieu, 35042 Rennes cedex, France
Tél: +33 (0) 2 99 84 71 33


