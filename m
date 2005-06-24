Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262966AbVFXIr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbVFXIr1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 04:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbVFXIml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 04:42:41 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:65139 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S261535AbVFXIlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 04:41:14 -0400
Message-ID: <42BBC710.8010906@cisco.com>
Date: Fri, 24 Jun 2005 18:40:48 +1000
From: Lincoln Dale <ltd@cisco.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>	 <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB5E1A.70903@namesys.com> <42BB7083.2070107@cisco.com> <42BBAD0F.2040802@namesys.com> <42BBB1FA.7070400@cisco.com> <42BBC2EC.2080000@namesys.com>
In-Reply-To: <42BBC2EC.2080000@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

>>>ow, if his target is reduced to whether we can eliminate a function
>>>indirection, and whether we can review the code together and see if it
>>>is easy to extend plugins and pluginids to other filesystems by finding
>>>places to make it more generic and accepting of per filesystem plugins,
>>>especially if it is not tied to going into 2.6.13, well, that is the
>>>conversation I would have liked to have had.
>>>
>>fantastic - some common ground.
>>any reason WHY there has to be an abstraction of 'pluginid' when in
>>theory VFS operations can already provide the necessary abstraction on
>>a per-object basis?
>>    
>>
>VFS supplies instances, plugins are classes.  If a language can
>instantiate an object, that does not eliminate the value of being able
>to create classes.
>
>Does it make sense to you now?
>  
>
you've lost me . . .

regardless, it isn't /me/ that you need to convince.  how about a 
posting to l-k on "why Reiser4 cannot use VFS infrastructure for 
[crypto,compression,blahblah] plugins" - ideally, for each plugin.


cheers,

lincoln.
