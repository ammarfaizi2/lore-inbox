Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWDNVgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWDNVgI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWDNVgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:36:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64389 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030190AbWDNVgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:36:07 -0400
Date: Fri, 14 Apr 2006 14:38:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Poll microoptimizations.
Message-Id: <20060414143820.6a04b696.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0604141413260.21335@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0604132115290.29982@shell3.speakeasy.net>
	<20060414123118.0a8fb24c.akpm@osdl.org>
	<Pine.LNX.4.58.0604141413260.21335@shell2.speakeasy.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov <vlobanov@speakeasy.net> wrote:
>
> I can put in a comment to explain what the code is doing, or if you
> think that the bitmasking itself is "yuk", then I can easily transform
> the code into an explicit "if () {}" block. :)

yes please.

> > Yuk.  Sorry, no.
> 
> Thank you for the review. The comments above are easy to address. Do you
> like the main concept behind the patch? Should I correct and resubmit?

I don't really understand it yet.

Yes, please resend and feel free to a) add comments in places where we can
help people to understand the code and b) convert any code which gets
touched to be coding-style-friendly.  (I usually recommend that we do that
even if the surrounding code uses different conventions - eventually
everything will be fixed ;))
