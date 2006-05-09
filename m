Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWEIOkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWEIOkH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWEIOkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:40:07 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:11472 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751347AbWEIOkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:40:06 -0400
Message-ID: <4460A9A0.5090404@tmr.com>
Date: Tue, 09 May 2006 10:39:28 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060409 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: www.softpanorama.org: sparc_vs_x86 fun
References: <200605041224.41827.vda@ilport.com.ua> <Pine.LNX.4.61.0605041322070.24957@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605041322070.24957@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

> while on SPARC, it takes 6 instructions (of course, being RISC makes it 
> execute differently than x64)
> 
>     sethi %g1, $some_upper_bits
>     or %g1, $next_bitgroup
>     (shift-left)
>     or %g1, $next_bitgroup
>     (shift-left)
>     or %g1, $last_bitgroup
> 
> BTW, T1 is cool, but that the 1U version only has space for 1 disk is 
> pretty limiting :/

I have to believe that you can load 64 bit constant data from memory and
don't have to do all this dancing with immediate loads. Therefore this
must be faster or they wouldn't do it this way. Or is this a point that
some unoptimized compiler could generate this code?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me


