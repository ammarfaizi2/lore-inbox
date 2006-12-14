Return-Path: <linux-kernel-owner+w=401wt.eu-S1751990AbWLNXmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbWLNXmV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbWLNXmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:42:20 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:60861 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbWLNXmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:42:20 -0500
Message-ID: <4581E192.3010108@oracle.com>
Date: Thu, 14 Dec 2006 15:43:14 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Scott Preece <sepreece@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
References: <20061207004838.4d84842c.randy.dunlap@oracle.com> <7b69d1470612141533v6ea076ap7149dbabceeb8ab4@mail.gmail.com>
In-Reply-To: <7b69d1470612141533v6ea076ap7149dbabceeb8ab4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Preece wrote:
[1]
>>  Outside of comments, documentation and except in Kconfig, spaces are 
>> never
>>  used for indentation, and the above example is deliberately broken.
> ---
> 
> I realize it isn't text you added, but what's that supposed to mean?
> Surely the 8-character indents are made up of spaces.  Does it mean

No, the 8-character indents are made of one ASCII TAB character.

> "spaces other than 8-space blocks"? In any case, how does it synch
> with the following chapter's statement that continuations " are placed
> substantially to the right" - isn't that done with spaces, too?

That's usually (preferably) done with tab(s).  Sometimes it is done
with a few spaces instead.  (and we put up with it :)

> Or am I just totally spacing out on what was meant?

I take [1] to mean that this example:

	if (condition) do_this;
	  do_something_everytime;

is broken in at least 3 ways:
1/ do_this(); should be on a separate line;
2/ do_something_everytime() should not be indented more than the "if"
	above it; and
3/ *if* do_something_everytime() were to be indented more than it is,
	it should be done with a tab, not spaces.

-- 
~Randy
