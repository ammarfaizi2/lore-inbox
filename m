Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbUATFlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 00:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUATFll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 00:41:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:14532 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264943AbUATFlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 00:41:39 -0500
From: Randy Dunlap <rddunlap@osdl.org>
Message-ID: <1252.4.5.45.142.1074577298.squirrel@www.osdl.org>
Date: Mon, 19 Jan 2004 21:41:38 -0800 (PST)
Subject: Re: [PATCH] bitmap parsing/printing routines, version 4
To: <joe.korty@ccur.com>
In-Reply-To: <20040120035756.GA15703@tsunami.ccur.com>
References: <20040114150331.02220d4d.pj@sgi.com>
        <20040115002703.GA20971@tsunami.ccur.com>
        <20040114204009.3dc4c225.pj@sgi.com>
        <20040115081533.63c61d7f.akpm@osdl.org>
        <20040115181525.GA31086@tsunami.ccur.com>
        <20040115161732.458159f5.pj@sgi.com>
        <400873EC.2000406@us.ibm.com>
        <20040117063618.GA14829@tsunami.ccur.com>
        <20040117183929.GA24185@tsunami.ccur.com>
        <400C4966.2030803@us.ibm.com>
        <20040120035756.GA15703@tsunami.ccur.com>
X-Priority: 3
Importance: Normal
Cc: <colpatch@us.ibm.com>, <pj@sgi.com>, <akpm@osdl.org>, <paulus@samba.org>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jan 19, 2004 at 01:17:26PM -0800, Matthew Dobson wrote:
>> Joe,
>>
>> Additions:
>> 4) A whole bunch of comments.  Are these all correct?
>>
>> None of the things in my patch (with the possible exception of #3)
>> change the functionality of the code, which looks great.
>>
>> Andrew, I agree with Paul's "thumbs-up" of Joe's patch.  My patch is
>> solely meant to increase the readability of the bitmap_parse function.
>>
>> Cheers!
>>
>> -Matt
>
> Indeed you are correct, the final (totaldigits == 1) test can be
> removed. Good catch.
>
> However, IMHO you added too many comments.  Unlike Andrew, I do believe
> one can have too many comments.  Comments become 'too many' when they
> dilute to the point that the code can no longer be clearly read.

Sure, some code can have too many comments, but most of Linux isn't
approaching that level.

> If you reduce the comments to just those that say something not easily
> deduced from the code, then they would be acceptable to me, and would
> make a useful addition IMO.  That would be all but three, or perhaps
> four, of them.
>
> Andrew, if you do like the fully commented version, then please remove
> my name from the comment in the patch.  The dilute style of coding is
> not one I wish to have my name associated with.

~Randy



