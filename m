Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUBOWWX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 17:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbUBOWWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 17:22:22 -0500
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:29375 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S265218AbUBOWWT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 17:22:19 -0500
From: Rusty Russell <rusty@au1.ibm.com>
To: johnrose@austin.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 PCI Hotplug Driver for RPA 
In-reply-to: Your message of "Tue, 10 Feb 2004 19:08:42 MDT."
             <200402110108.i1B18glq022737@localhost.localdomain> 
Date: Sun, 15 Feb 2004 19:58:29 +1100
Message-Id: <20040215222211.4F99817DE7@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200402110108.i1B18glq022737@localhost.localdomain> you write:
> +MODULE_PARM(debug, "i");

Please:
	module_param(debug, int, 0644);

It's for your own good... really...

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
