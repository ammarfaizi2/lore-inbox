Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266066AbTLIQvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266067AbTLIQvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:51:47 -0500
Received: from terminus.zytor.com ([63.209.29.3]:41189 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S266066AbTLIQvp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:51:45 -0500
Message-ID: <3FD5FD8C.7010608@zytor.com>
Date: Tue, 09 Dec 2003 08:51:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Arnd Bergmann <arnd@arndb.de>, Jamie Lokier <jamie@shareable.org>,
       Nikita Danilov <Nikita@Namesys.COM>, linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
References: <200312081646.42191.arnd@arndb.de> <Pine.LNX.4.58.0312082321470.18255@home.osdl.org> <3FD57C77.4000403@zytor.com> <200312091256.47414.arnd@arndb.de> <3FD5ED77.6070505@zytor.com> <Pine.LNX.4.58.0312090837370.19936@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312090837370.19936@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 9 Dec 2003, H. Peter Anvin wrote:
> 
>>In some ways, this is rather unfortunate, too.  What it really means is
>>that the gcc "m" constraint is overloaded; it would have been better if
>>they would have created a new modifier (say "*") for "must be lvalue."
> 
> 
> The thing is, most users of "m" (like 99%) actually mean "_THIS_ memory
> location". So just fixing the "m" modifier was an easy way to make sure
> that users get the behaviour they expect.
> 

Agreed.  It's just a bit ugly that the "m" in "rm" has a different 
meaning than just "m".

	-hpa

