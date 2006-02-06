Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWBFTa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWBFTa6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWBFTa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:30:58 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:27470 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932309AbWBFTa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:30:57 -0500
Message-ID: <43E7A447.2090601@sw.ru>
Date: Mon, 06 Feb 2006 22:32:23 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Dave Hansen <haveblue@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>	<Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>	<43E3915A.2080000@sw.ru>	<Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>	<m1lkwoubiw.fsf@ebiederm.dsl.xmission.com> <43E71018.8010104@sw.ru>	<m1hd7condi.fsf@ebiederm.dsl.xmission.com>	<1139243874.6189.71.camel@localhost.localdomain> <m13biwnxkc.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m13biwnxkc.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As someone said to me a little bit ago, for migration or checkpointing
> ultimately you have to capture the entire user/kernel interface if
> things are going to work properly.  Now if we add this facility to
> the kernel and it is a general purpose facility.  It is only a matter
> of time before we need to deal with nested containers.
Fully virtualized container is not a matter of virtualized ID - it is 
the easiest thing to do actually, but a whole global problem of other 
resources virtualization. We can ommit ID for now, if you like it more.

> Not considering the case of having nested containers now is just foolish.
> Maybe we don't have to implement it yet but not considering it is silly.
No one told that it is not considered. In fact PID virtualization send 
both by IBM/us is abstract and doesn't care whether containers are 
nested or not.

> As far as I can tell there is a very reasonable chance that when we
> are complete there is a very reasonable chance that software suspend
> will just be a special case of migration, done complete in user space.
> That is one of the more practical examples I can think of where this
> kind of functionality would be used.

Kirill

