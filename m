Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVAQSPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVAQSPO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVAQSOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:14:53 -0500
Received: from terminus.zytor.com ([209.128.68.124]:34260 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262832AbVAQSNa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:13:30 -0500
Message-ID: <41EBFF87.6080105@zytor.com>
Date: Mon, 17 Jan 2005 10:10:15 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: Arjan van de Ven <arjan@infradead.org>, Jan Hubicka <jh@suse.cz>,
       Jack F Vogel <jfv@bluesong.net>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>  <20050114205651.GE17263@kam.mff.cuni.cz>  <Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>  <cs9v6f$3tj$1@terminus.zytor.com>  <Pine.LNX.4.61.0501170909040.4593@ezer.homenet> <1105955608.6304.60.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0501171002190.4644@ezer.homenet>
In-Reply-To: <Pine.LNX.4.61.0501171002190.4644@ezer.homenet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> On Mon, 17 Jan 2005, Arjan van de Ven wrote:
> 
>>> Actually, having cc'd Linus made me think very _carefully_ about what I
>>> say and I went and checked how the userspace does it, as I couldn't
>>> believe that such fine piece of software as gdb would be broken as well.
>>> And to my surprize I discovered that gdb (when a program is compiled 
>>> with
>>> -g) works fine! I.e. it shows the function arguments correctly. And
>>
>> so why don't you use kgdb instead of kdb ?
> 
> If kdb was some dead unmaintained piece of software then, yes, I would 
> follow your advice and switch to kgdb. But kdb is a very nice and 
> actively maintained piece of work, so it should be fixed to show the 
> parameter values correctly in the backtrace.

That's a kdb maintainer issue.  The x86-64 folks have nicely provided a 
set of libraries to do backtraces, etc.  Your previous rant is just so 
far off base it's not even funny.

	-hpa
