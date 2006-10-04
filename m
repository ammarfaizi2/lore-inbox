Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWJDVth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWJDVth (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWJDVth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:49:37 -0400
Received: from smtp-out.google.com ([216.239.45.12]:31448 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751170AbWJDVtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:49:36 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=uOId+LSfrV0iE1CKdSYWtFvpL0GppPuxzAWBK40Mhk044T7YZfh2xaaf40Y+zlUxc
	rqR/8WygaNw7701xv6JzA==
Message-ID: <6599ad830610041449v5dfd9ef3r4fb1e3453a8e6144@mail.gmail.com>
Date: Wed, 4 Oct 2006 14:49:30 -0700
From: "Paul Menage" <menage@google.com>
To: sekharan@us.ibm.com
Subject: Re: [RFC][PATCH 0/4] Generic container system
Cc: pj@sgi.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, winget@google.com, mbligh@google.com,
       rohitseth@google.com, jlan@sgi.com, Joel.Becker@oracle.com,
       Simon.Derr@bull.net
In-Reply-To: <6599ad830610041440n74056262v63528c0d22ca5cb8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002095319.865614000@menage.corp.google.com>
	 <1159925752.24266.22.camel@linuxchandra>
	 <6599ad830610031934s41994158o59f1a2e58b1cb45e@mail.gmail.com>
	 <1159988217.24266.60.camel@linuxchandra>
	 <6599ad830610041440n74056262v63528c0d22ca5cb8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/06, Paul Menage <menage@google.com> wrote:
>
> > > > - Tight coupling of subsystems: I like your idea (you mentioned in a
> > > >   reply to the previous thread) of having an array of containers in task
> > > >   structure than the current implementation.
> > >

...

BTW, that's not to say that having parallel hierarchies of containers
is necessarily a bad thing - I can imagine just mounting multiple
instances of containerfs, each managing one of the container pointers
in task_struct - but I think that could be added on afterwards. Even
if we did have the parallel support, we'd still need to support
multiple subsystems/controllers on the same hierarchy, since I think
that's going to be the much more common case.

Paul
