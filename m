Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163418AbWLGVgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163418AbWLGVgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163422AbWLGVgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:36:47 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:16406 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163418AbWLGVgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:36:46 -0500
Message-ID: <4578896C.3080504@oracle.com>
Date: Thu, 07 Dec 2006 13:36:44 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
References: <20061207004838.4d84842c.randy.dunlap@oracle.com> <Pine.LNX.4.61.0612071206160.2863@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612071206160.2863@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> On Dec 7 2006 00:48, Randy Dunlap wrote:
>> +The preferred way to ease multiple indentation levels in a switch
>> +statement is to align the "switch" and its subordinate "case" labels in
>> +the same column instead of "double-indenting" the "case" labels.  E.g.:
>> +
>> +	switch (suffix) {
>> +	case 'G':
>> +	case 'g':
>> +		mem <<= 10;
>> +	case 'M':
>> +	case 'm':
>> +		mem << 10;
>                 ^^^^^^^^^^
> 
> Statement has no effect ;-)

Argh, thanks, fixed these.
And removed most fall-throughs to make it a better example.

>> +Use one space around (on each side of) most binary operators, such as
>> +any of these:
>> +		=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=
> 
> And the ternary operator ?:

Added.

>> +but no space after unary operators:
>> +		sizeof  ++  --  &  *  +  -  ~  !  defined
> 
> And no space before these unary operators,
> ++ (postincrement) -- (postdecrement)
> 
> What keyword is "defined"? Did you have too much Perl coffee? :)
> 
>> +and no space around the '.' unary operator.
> 
> Same goes for ->

Added.

>> +Linux style for comments is the pre-C99 "/* ... */" style.
> 
> Aka C89.

Changed.

>> +Don't use C99-style "// ..." comments.
>> +
>> +The preferred style for long (multi-line) comments is:
>> +
>> +	/*
>> +	 * This is the preferred style for multi-line
>> +	 * comments in the Linux kernel source code.
>> +	 * Please use it consistently.
>> +	 */
> 
> Description: Stars to the left with two almost blank (/*, */) lines.

Added.

Thanks.  Will resend later today...

-- 
~Randy
