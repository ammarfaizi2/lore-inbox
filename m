Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271006AbUJUWIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271006AbUJUWIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270998AbUJUWGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:06:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:14501 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271006AbUJUWBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:01:24 -0400
Date: Thu, 21 Oct 2004 15:01:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] HVSI reset support
In-Reply-To: <1098376307.12020.42.camel@localhost>
Message-ID: <Pine.LNX.4.58.0410211459360.2269@ppc970.osdl.org>
References: <1098376307.12020.42.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Oct 2004, Hollis Blanchard wrote:
>
> Hi Linus, this patch adds support for when the service processor (the
> other end of the console) resets due to a critical error; we can resume
> the connection when it comes back. Please apply.

Hmm.. Your revision numbers seem to imply that this is against something 
that is from before my latest tty update that touched that file (which 
removes the user/kernel pointer distractions).

Just to make me happier, mind checking this with current -BK first?

		Linus
