Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265159AbTLFNTj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 08:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265160AbTLFNTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 08:19:39 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:26129 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S265159AbTLFNTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 08:19:38 -0500
Message-ID: <3FD1D86F.7070603@kolumbus.fi>
Date: Sat, 06 Dec 2003 15:23:59 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Numaq in 2.4 and 2.6
References: <3FD1A54F.101@kolumbus.fi> <20031206112348.GP8039@holomorphy.com> <3FD1C94C.1020104@kolumbus.fi> <20031206123622.GQ8039@holomorphy.com> <3FD1D4F6.7000106@kolumbus.fi> <20031206130724.GR8039@holomorphy.com>
In-Reply-To: <20031206130724.GR8039@holomorphy.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 06.12.2003 15:21:37,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 06.12.2003 15:20:47,
	Serialize complete at 06.12.2003 15:20:47
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>On Sat, Dec 06, 2003 at 03:09:10PM +0200, Mika Penttil? wrote:
>  
>
>>and later in same function :
>>phys_cpu_present_map |= apicid_to_phys_cpu_present(m->mpc_apicid);
>>but _not_
>>phys_cpu_present_map |= apicid_to_phys_cpu_present(logical_apicid);
>>as one would expect (and would make it identical to 2.6 behaviour).... A 
>>bug?
>>    
>>
>
>You may very well have just debugged an issue I've had with 2.4 on
>the things. =)
>
>
>  
>
And that would explain my confusion in the first place...I don't have 
the hardware, so feel free to submit a patch to  someone responsible for 
this area if you like... Anyway thanks for your explanations!

--Mika


