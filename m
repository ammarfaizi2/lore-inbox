Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268702AbUIQLbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbUIQLbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 07:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268698AbUIQL2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 07:28:38 -0400
Received: from [195.23.16.24] ([195.23.16.24]:12450 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268699AbUIQL1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 07:27:21 -0400
Message-ID: <414ACA14.1000608@grupopie.com>
Date: Fri, 17 Sep 2004 12:27:16 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409161457.08544.vda@port.imtp.ilyichevsk.odessa.ua> <20040916121747.GQ9106@holomorphy.com> <200409171201.15158.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200409171201.15158.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.10; VDF: 6.27.0.65; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Thursday 16 September 2004 15:17, William Lee Irwin III wrote:
>>Did the kallsyms patches reduce the cpu overhead from get_wchan()?
> 
> 
> Yes. top does not hog CPU anymore. It takes even a liitle bit *less*
> CPU than in 2.4 now.

Great!

I was the one who wrote those patches, so I'm glad to know that they 
actually made a difference in real world workloads (like using "top").

Reading /proc/kallsyms should be a lot faster too, although there is no 
comparison with 2.4 kernel, because there where no kallsyms there. It 
can be compared with previous 2.6 kernels, though.

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
