Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVIMG63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVIMG63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 02:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVIMG63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 02:58:29 -0400
Received: from smtpout.mac.com ([17.250.248.70]:49372 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932415AbVIMG62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:58:28 -0400
In-Reply-To: <24229.1126594413@kao2.melbourne.sgi.com>
References: <24229.1126594413@kao2.melbourne.sgi.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8AD020BA-CBF6-49DC-AFAC-DDBA883B191D@mac.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: asm-offsets.h is generated in the source tree
Date: Tue, 13 Sep 2005 02:58:01 -0400
To: Keith Owens <kaos@sgi.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 13, 2005, at 02:53:33, Keith Owens wrote:
> On Tue, 13 Sep 2005 02:48:43 -0400,
> Kyle Moffett <mrmacman_g4@mac.com> wrote:
>
>> On Mon, Sep 12, 2005 at 09:15:25PM +0200, Sam Ravnborg wrote:
>>
>>> o Use some magic define trick like:
>>>   - #include "ARCHDIR##foo.h"
>>>   - I cannot recall correct syntax but something like this is doable
>>>
>>
>> The syntax for that is one of the following:
>>
>> # define STR(x) #x
>> # define XSTR(x) STR(x)
>>
>
> Already exists, see include/linux/stringify.h

Well, yes, but I was illustrating the complete generic technique.  If
you put all the defines in appropriate other headers, then all you need
are the #include ANGLE_INCLUDE(baz.h) and #include QUOTE_INCLUDE(baz.h)
lines :-D.


Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because
life wouldn't have any meaning for them if they didn't. That's why I  
draw
cartoons. It's my life."
   -- Charles Shultz


