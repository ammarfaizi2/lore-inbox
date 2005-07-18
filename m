Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVGRLQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVGRLQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 07:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVGRLQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 07:16:28 -0400
Received: from [195.23.16.24] ([195.23.16.24]:62373 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261350AbVGRLQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 07:16:26 -0400
Message-ID: <42DB8F7B.30100@grupopie.com>
Date: Mon, 18 Jul 2005 12:16:11 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signed char fixes for scripts
References: <1121465068l.13352l.0l@werewolf.able.es> <1121465683l.13352l.5l@werewolf.able.es> <20050716095216.GB8064@mars.ravnborg.org>
In-Reply-To: <20050716095216.GB8064@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Fri, Jul 15, 2005 at 10:14:43PM +0000, J.A. Magallon wrote:
> 
>>On 07.16, J.A. Magallon wrote:
>>[...]
>>This time I did not break anything... and they shut up gcc4 ;)
> 
> Thanks.
> Can you please resend with proper changelog and signed-off-by.
> Diff should be done on top of latest -linus preferable.
> Also this patch seems relative small compared to the others floating
> around to cure signed warnings in scripts/
> Does this really fix all of them or only a subset of the warnings?

Well, current -linus already has a patch from me to change the 
compression scheme that also fixes most of the signedness problems. The 
ones below escaped me because my gcc3.3.2 didn't complain about them 
even with all the -W[xxx] switches I could find.

This takes a big hunk out of previous patches I've seen, so that might 
explain the difference.

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
