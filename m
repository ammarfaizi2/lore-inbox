Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUEKIIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUEKIIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUEKIIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:08:45 -0400
Received: from colin2.muc.de ([193.149.48.15]:18438 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262382AbUEKIIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:08:44 -0400
Date: 11 May 2004 10:08:43 +0200
Date: Tue, 11 May 2004 10:08:43 +0200
From: Andi Kleen <ak@muc.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       randy.dunlap@osdl.org, Sam Ravnborg <sam@ravnborg.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Sort kallsyms in name order: kernel shrinks by 30k
Message-ID: <20040511080843.GB8751@colin2.muc.de>
References: <1084252135.31802.312.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084252135.31802.312.camel@bach>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 03:08:55PM +1000, Rusty Russell wrote:
> Admittedly, anyone who sets CONFIG_KALLSYMS doesn't care about space,
> it's a fairly trivial change.

As long as nobody does binary search it's good. Wonder why I did not
have this idea already with the original stem compression change ;-)

-Andi
