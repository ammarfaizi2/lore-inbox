Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbTIEVSH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTIEVSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:18:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40439 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262556AbTIEVRC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:17:02 -0400
Message-ID: <3F58FD2D.40100@mvista.com>
Date: Fri, 05 Sep 2003 14:16:29 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yann Droneaud <yann.droneaud@mbda.fr>
CC: root@chaos.analogic.com,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>,
       linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
References: <20030904104245.GA1823@leto2.endorphin.org> <3F5741BD.5000401@mbda.fr> <Pine.LNX.4.53.0309041001090.3367@chaos> <3F57527B.7050204@mbda.fr>
In-Reply-To: <3F57527B.7050204@mbda.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yann Droneaud wrote:
> Richard B. Johnson wrote:
> 
> 
>>GAS also has macro capability. It's just "strange". However, it
>>does everything MASM (/ducks/) can do. It's just strange, backwards, etc.
>>It takes some getting used to.
>>
>>If you decide to use gcc as a preprocessor, you can't use comments,
>>NotGood(tm) because the "#" and some stuff after it gets "interpreted"
>>by cpp.
>>
> 
> 
> Yep, this is why arch/i386/boot/Makefile use -traditional flag.

Isn't this throwing out the baby with the bath?  It makes writting a 
header that is use in both C and ASM all that much harder.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

