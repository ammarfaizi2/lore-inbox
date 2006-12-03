Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760123AbWLCV0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760123AbWLCV0S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 16:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760124AbWLCV0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 16:26:18 -0500
Received: from smtp.osdl.org ([65.172.181.25]:8596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1760122AbWLCV0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 16:26:17 -0500
Date: Sun, 3 Dec 2006 13:26:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: minyard@acm.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH 4/12] IPMI: Allow hot system interface remove
Message-Id: <20061203132608.06434621.akpm@osdl.org>
In-Reply-To: <20061202045606.GA31143@localdomain>
References: <20061202045606.GA31143@localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 22:56:06 -0600
Corey Minyard <minyard@acm.org> wrote:

> 
> This modifies the IPMI driver so that a lower-level interface can be
> dynamically removed while in use so it can support hot-removal of
> hardware.
> 
> It also adds the ability to specify and dynamically change the
> IPMI interface the watchdog timer and the poweroff code use.
> 

Lots of new code here.  Has it all been runtime-tested under full debug
mode and lockdep, as per Documentation/SubmitChecklist?
