Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268300AbUJDShJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268300AbUJDShJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268304AbUJDShJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:37:09 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:47762 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S268300AbUJDShG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:37:06 -0400
Message-ID: <4161989F.9050607@tmr.com>
Date: Mon, 04 Oct 2004 14:38:23 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc -align options .config-settable
References: <200410012226.23565.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410012226.23565.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> Resend.
> 
> With all alignment options set to 1 (minimum alignment),
> I've got 5% smaller vmlinux compared to one built with
> default code alignment.

It would be interesting to know if this is better WRT cache usage than 
alignment which ensures that loops fit within the minimum number of 
cache lines. That's not quite the same thing as starting on a cache line 
in all cases.

This may be of interest to embedded builds.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
