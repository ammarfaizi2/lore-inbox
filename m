Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbUBDXmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbUBDXlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:41:39 -0500
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:20905 "EHLO
	kartuli.timesys") by vger.kernel.org with ESMTP id S264855AbUBDXkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:40:08 -0500
Message-ID: <402182B8.7030900@timesys.com>
Date: Wed, 04 Feb 2004 18:39:36 -0500
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: kgdb support in vanilla 2.6.2
References: <20040204230133.GA8702@elf.ucw.cz> <20040204152137.500e8319.akpm@osdl.org>
In-Reply-To: <20040204152137.500e8319.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Pavel Machek <pavel@ucw.cz> wrote:
>  
>
>>It seems that some kgdb support is in 2.6.2-linus:
>>    
>>
>
>Lots of architectures have had in-kernel kgdb support for a long time. 
>Just none of the three which I use :(
>
>I wouldn't support inclusion of i386 kgdb until it has had a lot of
>cleanup, possible de-featuritisification and some thought has been applied
>to splitting it into arch and generic bits.  It's quite a lot of work.
>  
>

Amit has started at least the third activity--he has split much of kgdb
into arch and generic bits.

Could you elaborate a little on the first two?

What major kinds of cleanup are we talking about?  Style issues?

What features (or classes of features) do you find excessive?  Would
it be sufficient to add a few config items to control subfeatures
of kgdb?

These are not idle questions.  If the amount of work to get it ready
for acceptance is tractable, I know a company that may be willing to
pay to have the work done.

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
