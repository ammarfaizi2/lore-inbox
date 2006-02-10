Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWBJGZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWBJGZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 01:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWBJGZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 01:25:52 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:32662 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751155AbWBJGZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 01:25:52 -0500
Message-ID: <43EC317C.9090101@sw.ru>
Date: Fri, 10 Feb 2006 09:23:56 +0300
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: devel@openvz.org
CC: Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, frankeh@watson.ibm.com,
       Andrey Savochkin <saw@sawoct.com>, Rik van Riel <riel@redhat.com>,
       greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Pavel Machek <pavel@ucw.cz>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       serue@us.ibm.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
Subject: Re: [Devel] Re: swsusp done by migration (was Re: [RFC][PATCH 1/5]
 Virtualization/containers: startup)
References: <43E38BD1.4070707@openvz.org>	<Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>	<43E3915A.2080000@sw.ru>	<Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>	<m1lkwoubiw.fsf@ebiederm.dsl.xmission.com> <43E71018.8010104@sw.ru>	<m1hd7condi.fsf@ebiederm.dsl.xmission.com>	<1139243874.6189.71.camel@localhost.localdomain>	<m13biwnxkc.fsf@ebiederm.dsl.xmission.com>	<20060208215412.GD2353@ucw.cz>	<m1mzh02y3m.fsf@ebiederm.dsl.xmission.com>	<7CCC1159-BF55-4961-BC24-A759F893D43F@mac.com> <43EC170C.6090807@vilain.net>
In-Reply-To: <43EC170C.6090807@vilain.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> Kyle Moffett wrote:
>> <wishful thinking>
>> I can see another extension to this functionality.  With appropriate 
>> changes it might also be possible to have a container exist across 
>> multiple computers using some cluster code for synchronization and 
>> fencing.  The outermost container would be the system boot container, 
>> and multiple inner containers would use some sort of network-
>> container-aware cluster filesystem to spread multiple vservers across 
>> multiple servers, distributing CPU and network load appropriately.
>> </wishful thinking>
> 
> Yeah.  If you fudged/virtualised /dev/random, the system clock, etc you
> could even have Tandem-style transparent High Availability.
> </more wishful thinking>

Could you please explain, why you want to virtualize /dev/random?

Tnank you,
	Vasily Averin

Virtuozzo Linux Kernel Team
