Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVBGRnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVBGRnH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVBGRnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:43:07 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:39813 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261251AbVBGRnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:43:02 -0500
Subject: Re: [PATCH] PCI Hotplug: remove incorrect rpaphp firmware
	dependency
From: John Rose <johnrose@austin.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com.torvalds, akpm@osdl.org
In-Reply-To: <1107795637.19262.426.camel@hades.cambridge.redhat.com>
References: <200502031908.j13J8ggb031915@hera.kernel.org>
	 <1107795637.19262.426.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1107798068.31219.6.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Feb 2005 11:41:08 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Er, use the result of the get_children_props() call only if it _failed_?
> I suspect that wasn't your intention. This makes my G5 boot again:

Doh, good catch!  This was an oversight while patching multiple trees
for this bug.  Previous versions of that function use 1 for success. 
Sigh.  BTW, you're running an RPA module on your G5?

Thanks-
John

