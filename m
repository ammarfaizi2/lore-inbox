Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265612AbUAZLfP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 06:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265607AbUAZLfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 06:35:15 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:31322 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265612AbUAZLfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 06:35:08 -0500
Date: Mon, 26 Jan 2004 06:35:06 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Karim Yaghmour <karim@opersys.com>
cc: Nuno Silva <nuno.silva@vgertech.com>, JustFillBug <mozbugbox@yahoo.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Cooperative Linux
In-Reply-To: <4014B573.1020703@opersys.com>
Message-ID: <Pine.LNX.4.44.0401260633280.26321-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jan 2004, Karim Yaghmour wrote:

> So, for example, Xen assumes that all OSes are going to use the same
> devices for I/O: same disk, same NIC, etc. It therefore implements lots
> of virtual devices for these.

Consolidation means more efficient hardware use ...

> Wouldn't it be just better to reuse the existing work on the hotplug
> hardware (hotplug CPU, hotplug memory, etc.) to have the kernels
> get/return hardware resources to the nanokernel?

That means a loss of flexibility.  Furthermore, these hotplug
patches don't seem ready yet.

Rik
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

