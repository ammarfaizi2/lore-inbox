Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWBFQiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWBFQiN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWBFQiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:38:13 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:20359 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932202AbWBFQiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:38:12 -0500
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
In-Reply-To: <m1hd7condi.fsf@ebiederm.dsl.xmission.com>
References: <43E38BD1.4070707@openvz.org>
	 <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru>
	 <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>
	 <m1lkwoubiw.fsf@ebiederm.dsl.xmission.com> <43E71018.8010104@sw.ru>
	 <m1hd7condi.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 08:37:54 -0800
Message-Id: <1139243874.6189.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 02:19 -0700, Eric W. Biederman wrote:
> That you placed the namespaces in a separate structure from
> task_struct.
> That part seems completely unnecessary, that and the addition of a
> global id in a completely new namespace that will be a pain to
> virtualize
> when it's time comes. 

Could you explain a bit why the container ID would need to be
virtualized?

-- Dave


