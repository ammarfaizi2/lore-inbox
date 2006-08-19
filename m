Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWHSCqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWHSCqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 22:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWHSCqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 22:46:11 -0400
Received: from gw.goop.org ([64.81.55.164]:43746 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751351AbWHSCqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 22:46:10 -0400
Message-ID: <44E67B6E.10706@goop.org>
Date: Sat, 19 Aug 2006 03:46:06 +0100
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain> <44DB7596.6010503@goop.org> <20060819012133.GH7813@stusta.de>
In-Reply-To: <20060819012133.GH7813@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> These are Linux specific operations.
>
> Without an _GPL you are in the grey area where courts have to decide 
> whether a module using this would be a derived work according to 
> copyright law in $country_of_the_court and therefore has to be GPL.
>
> With the _GPL, everything is clear without any lawyers involved.
>   

Hardly.  The _GPL is a hint as to the intent of the author, but it is no 
more than a hint.

My intent here (and I think the intent of the other authors) is not to 
cause breakage of things which currently work, so the _GPL is not 
appropriate for that reason.  Paravirt_ops is a restatement of many 
interfaces which already exist in Linux in a non-_GPL form, so making 
the structure _GPL is effectively relicensing them.

    J
