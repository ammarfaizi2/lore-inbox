Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbWJJMww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWJJMww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWJJMww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:52:52 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63676 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965163AbWJJMww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:52:52 -0400
Message-ID: <452B979C.9030001@garzik.org>
Date: Tue, 10 Oct 2006 08:52:44 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: bcollins@debian.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firewire: handle sysfs errors
References: <20061010064805.GA21310@havoc.gtf.org> <452B5BEE.4050407@s5r6.in-berlin.de>
In-Reply-To: <452B5BEE.4050407@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> drivers/ieee1394/nodemgr.c: In function `fw_set_rescan':
> drivers/ieee1394/nodemgr.c:417: warning: 'rc' might be used
> uninitialized in this function
> 
> The rest of the patch looks OK.

shoops, sorry


> I get a lot more warn_unused_result warnings at other places in
> ieee1394/nodemgr.c and ieee1394/hosts.c though. I could fix them all up
> and fix this new warning in fw_set_rescan too if you don't mind...

That would be fantastic...

	Jeff


