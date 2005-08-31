Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbVHaTtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbVHaTtY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 15:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbVHaTtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 15:49:22 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:35485 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751015AbVHaTtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 15:49:22 -0400
Message-ID: <43160A70.8020701@t-online.de>
Date: Wed, 31 Aug 2005 21:52:16 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Jochen Hein <jochen@jochen.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be> <43149E5B.7040006@t-online.de> <Pine.LNX.4.61.0508302039160.3743@scrub.home> <4314DD2E.7060901@t-online.de> <Pine.LNX.4.61.0508310159290.3728@scrub.home> <4315A6AB.5090108@t-online.de> <Pine.LNX.4.61.0508311750140.3728@scrub.home> <431602CC.1030008@t-online.de> <Pine.LNX.4.61.0508312125360.3743@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0508312125360.3743@scrub.home>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: Z1ZwVYZJ8eWv6zHkSENtUrIX1ol5vdLWWxgXXYLXCcUIVfUFpea+Qm@t-dialin.net
X-TOI-MSGID: 8981dd6d-9463-43df-80ab-62834d3ffaf6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>The special case for s_pitch == 2 saves about 270 ms system time (2120 ->
>>1850ms)
>>with a 16x30 font.
>>    
>>
>Compared to what? How much is the function call overhead?
>
>  
>
Your version of the inline code inserted after an if (idx==2) in 
bit_putcs against my version of the
inline code.

cu,
 knut

