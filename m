Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTHFOUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTHFOUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:20:35 -0400
Received: from ns.suse.de ([213.95.15.193]:58888 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263637AbTHFOUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:20:34 -0400
To: "Hao CD Wu" <haowu@cn.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where can I get agp driver developer's guide
References: <OF6F25769B.C6371B4F-ON48256D7A.003364BE@cn.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Aug 2003 16:20:31 +0200
In-Reply-To: <OF6F25769B.C6371B4F-ON48256D7A.003364BE@cn.ibm.com.suse.lists.linux.kernel>
Message-ID: <p73ispaook0.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hao CD Wu" <haowu@cn.ibm.com> writes:

> I searched network to find some documents about agp driver but I can't find
> any. I am very greatful if anyone can tell me where I can get agp driver's
> documents, especially developer's guide on how to implement a special agp
> dirver.

There is no particular documentation for that. The usual way to get
a new one is to copy an existing driver and modify it for your needs.

> 
> And I notice that the function agp_register_driver is no longer exist in
> kernel 2.5.70, but it exists in kernel 2.5.64 or later. I am wonder how to
> register a agp driver in in kernel 2.5.70.

You use agp_alloc_bridge/agp_add_bridge to register the AGP bridge.

Out of curiosity: for what chipset do you want to write an AGP driver
for?

-Andi
