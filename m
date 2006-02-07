Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbWBGQRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbWBGQRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbWBGQRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:17:20 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:6021 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965152AbWBGQRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:17:20 -0500
Message-ID: <43E8C84D.6020107@sw.ru>
Date: Tue, 07 Feb 2006 19:18:21 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Sam Vilain <sam@vilain.net>, Rik van Riel <riel@redhat.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, kuznet@ms2.inr.ac.ru,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>	<43E83E8A.1040704@vilain.net> <m1oe1jfa5n.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1oe1jfa5n.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I can't think of any real use cases where you would specifically want A)
>>without B).

> You misrepresent my approach.  
[...]

> Second I am not trying to just implement a form of virtualizing PIDs.
> Heck I don't intend to virtualize anything.  The kernel has already
> virtualized everything I require.  I want to implement multiple
> instances of the current kernel global namespaces.  All I want is
> to be able to use the same name twice in user space and not have
> a conflict.
if you want not virtualize anything, what is this discussion about? :)
can you provide an URL to your sources? you makes lot's of statements 
about that your network virtualization solution is better/more complete, 
so I'd like to see your solution in whole rather than only words.
Probably this will help.

> I disagree with a struct container simply because I do not see what
> value it happens to bring to the table.  I have yet to see a problem
> that it solves that I have not solved yet.
again, source would help to understand your solution and problem you 
solved and not solved yet.

> In addition I depart from vserver and other implementations in another
> regard.  It is my impression a lot of their work has been done so
> those projects are maintainable outside of the kernel, which makes
> sense as that is where those code bases live.  But I don't think that
> gives the best solution for an in kernel implementation, which is
> what we are implementing.
These soltuions are in kernel implementations actually.


Kirill

