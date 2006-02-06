Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWBFWlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWBFWlS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWBFWlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:41:17 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:57211 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932412AbWBFWlR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:41:17 -0500
Message-ID: <43E7D077.2090903@fr.ibm.com>
Date: Mon, 06 Feb 2006 23:40:55 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>	<Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>	<43E3915A.2080000@sw.ru>	<Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>	<m1lkwoubiw.fsf@ebiederm.dsl.xmission.com> <43E71018.8010104@sw.ru>	<m1hd7condi.fsf@ebiederm.dsl.xmission.com>	<1139243874.6189.71.camel@localhost.localdomain> <m13biwnxkc.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m13biwnxkc.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> As someone said to me a little bit ago, for migration or checkpointing
> ultimately you have to capture the entire user/kernel interface if
> things are going to work properly.  Now if we add this facility to
> the kernel and it is a general purpose facility.  It is only a matter
> of time before we need to deal with nested containers.
>
> Not considering the case of having nested containers now is just foolish.
> Maybe we don't have to implement it yet but not considering it is silly.

That could be restricted. Today, process groups are not nested. Why do you
think nested containers are inevitable ?

> As far as I can tell there is a very reasonable chance that when we
> are complete there is a very reasonable chance that software suspend
> will just be a special case of migration, done complete in user space.

Being able to sofware suspend one container among many would be a very
interesting feature to have.

C.
