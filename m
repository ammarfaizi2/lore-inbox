Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVAMVW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVAMVW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVAMVTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:19:18 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:35301 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261699AbVAMVPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:15:44 -0500
Subject: Re: security contact draft
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wright <chrisw@osdl.org>
Cc: akpm@osdl.org, torvalds@osdl.org, marcelo.tosatti@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113125503.C469@build.pdx.osdl.net>
References: <20050113125503.C469@build.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105647058.4624.134.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 20:10:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 20:55, Chris Wright wrote:
> To keep the conversation concrete, here's a pretty rough stab at
> documenting the policy.

It's not documenting the stuff Linus seems to be talking about which is
a public list ? Or does Linus want both ?

>  It is preferred that mail sent to the security contact is encrypted
>  with $PUBKEY.

https:// and bugs.kernel.org ? You can make bugzilla autoprivate
security bugs and alert people.

>  well-tested or for vendor coordination.  However, we expect these delays
>  to be short, measurable in days, not weeks or months.  As a basic default
>  policy, we expect report to disclosure to be on the order of $NUMDAYS.

Sounds good. $NUMDAYS is going to require some debate. My gut feeling is
14 days is probably the right kind of target for hard stuff remembering
how long it takes to run QA on an enterprise grade kernel. If it gets
too short then vendors are going to disclose elsewhere for their own
findings and only to this list when they are all ready anyway which
takes us back to square one.

And many are probably a lot less - those nobody is going to rush out and
build new vendor kernels for, or those that prove to be non serious can
probably get bumped to the public list by the security officer within a
day or two.

Alan

