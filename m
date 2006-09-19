Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752013AbWISCJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbWISCJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 22:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbWISCJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 22:09:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36489 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752013AbWISCJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 22:09:17 -0400
Date: Mon, 18 Sep 2006 19:09:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: tarka@internode.on.net (Steve Smith)
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>
Subject: Re: Repeatable hang on boot with PCMCIA card present
Message-Id: <20060918190902.d5b6a698.akpm@osdl.org>
In-Reply-To: <20060916050331.GA6685@lucretia.remote.isay.com.au>
References: <20060916050331.GA6685@lucretia.remote.isay.com.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2006 15:03:31 +1000
tarka@internode.on.net (Steve Smith) wrote:

> [I sent the following to the person responsible for the patch but
> haven't heard anything so I assume he's unavailable...]
> 
> Hi,
> 
> With recent kernel releases I have started seeing consistent hangs
> during boot when a PCMCIA card is present in the slot (the card in
> question is a Linksys wireless-B card).  The symptoms are:
> 
>     If the card is present during boot an error of "Unknown interrupt
>     or fault at EIP ..." appears.
> 
>     If the card is not present there is no error.
> 
>     The card can be plugged-in post-boot without problems.
> 
> Using git-bisect I have narrowed down the error to one commit, namely
> "use bitfield instead of p_state and state".  The commit# is
> 
>     e2d4096365e06b9a3799afbadc28b4519c0b3526
>
> However I am still seeing this problem with the latest -RC releases.

Thanks for doing that.

Damn, that was a huge patch.  Have you been able to grab
a copy of the oops output?  It would really help.  Even a photo of
the screen..


