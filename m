Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVLTIVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVLTIVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbVLTIVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:21:14 -0500
Received: from smtp109.plus.mail.mud.yahoo.com ([68.142.206.242]:25773 "HELO
	smtp109.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750845AbVLTIVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:21:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=WDFIHMyeeBIwXio3PRrE7zSFFrkACufSacaEBmrUA45qFonSIPaN/Xav1b7Nw/DWqmanNJn+DclHj8DMZ5Vg0sL3FBnrcLSwS6LbQCMAAbV9jtGCIpq+2X0OzFp9JEqf646XMH7DEh0kc+eyJAX/Zb9KpgIdB4+lqni6nDbry84=  ;
Message-ID: <43A7BEF6.3010202@yahoo.com.au>
Date: Tue, 20 Dec 2005 19:21:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
References: <20051219013415.GA27658@elte.hu>	 <20051219042248.GG23384@wotan.suse.de>	 <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org>	 <20051219155010.GA7790@elte.hu>	 <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org>	 <20051219195553.GA14155@elte.hu>	 <Pine.LNX.4.64.0512191203120.4827@g5.osdl.org>	 <43A7BAB5.7020201@yahoo.com.au> <1135066007.2952.4.camel@laptopd505.fenrus.org>
In-Reply-To: <1135066007.2952.4.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>If we agree mutex is a good idea at all (and I think it is), then
>>wouldn't it be better to aim for a wholesale conversion rather than
>>"if people want to"?
> 
> 
> well most of this will "only" take a few kernel releases ;-)
> 

OK, so in my mind that is aiming for a wholesale conversion. And
yes I would expect the semaphore to stay around for a while...

But I thought Linus phrased it as though mutex should be made
available and no large scale conversions.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
