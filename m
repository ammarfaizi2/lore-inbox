Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbUJ0TYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbUJ0TYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbUJ0TW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:22:57 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:10650 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262600AbUJ0TPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:15:32 -0400
Message-ID: <417FF43C.5050208@tmr.com>
Date: Wed, 27 Oct 2004 15:17:16 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: "H. Peter Anvin" <hpa@zytor.com>, Tonnerre <tonnerre@thundrix.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
Subject: Re: The naming wars continue...
References: <417F2251.7010404@zytor.com><417F2251.7010404@zytor.com> <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Wednesday 27 October 2004 07:21, H. Peter Anvin wrote:
> 
>>Tonnerre wrote:
>>
>>>Salut,
>>>
>>>On Tue, Oct 26, 2004 at 02:43:54PM +0300, Denis Vlasenko wrote:
>>>
>>>
>>>>Having /usr/XnnRmm was a mistake in the first place.
>>>
>>>
>>>BSD has /X11R6, whilst I'd agree that /opt/xorg is probably a lot more
>>>appropriate. If you want I can  take this discussion back to the X.Org
>>>folks again, but I don't think it's actually going to change anything.
>>>
>>
>>/opt/X (or /usr/X) is really what it probably should be.
> 
> 
> Why there is any distinction between, say, gcc and X?
> KDE and Midnight Commander? etc... Why some of them go
> to /opt while others are spread across dozen of dirs?
> This seems to be inconsistent to me.

At one time Sun had the convention that things in /usr could be mounted 
ro on multiple machines. That worked, it predates Linux so Linux was the 
o/s which chose to go another way, and it covered the base things in a 
system.

That actually seems like a good way to split a networked environment, 
with /bin and /sbin having just enough to get the system up and mount 
/usr. I can't speak to why that is being done differently now.

I guess someone was nervous about mounting a local /usr/local on a 
(possibly) network mounted /usr and theu /opt, but that's a guess on my 
part as well.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
