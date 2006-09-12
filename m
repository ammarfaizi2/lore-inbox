Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbWILI6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWILI6H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWILI6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:58:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48025 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965079AbWILI6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:58:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.0609082216070.8541-100000@netrider.rowland.org> 
References: <Pine.LNX.4.44L0.0609082216070.8541-100000@netrider.rowland.org> 
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, paulmck@us.ibm.com,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 12 Sep 2006 09:57:39 +0100
Message-ID: <31512.1158051459@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd state it as:

	mb() _implies_ both rmb() and wmb(), but is more complete than both
	since it _also_ partially orders reads and writes with respect to each
	other.

David
