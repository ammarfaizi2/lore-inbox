Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVC3PZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVC3PZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 10:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVC3PZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 10:25:32 -0500
Received: from colin2.muc.de ([193.149.48.15]:2060 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262219AbVC3PZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 10:25:29 -0500
Date: 30 Mar 2005 17:25:27 +0200
Date: Wed, 30 Mar 2005 17:25:27 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. J. Lu" <hjl@lucon.org>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment register access)
Message-ID: <20050330152527.GD12672@muc.de>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org> <m14qev3h8l.fsf@muc.de> <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org> <20050330015312.GA27309@lucon.org> <Pine.LNX.4.58.0503291815570.6036@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503291815570.6036@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	unsigned gsindex;
> > 	asm volatile("movl %%gs,%0" : "=g" (gsindex));
> 
> Ok, that's a real x86-64 bug, it seems. Andi, please fix, preferably by 
> just making the "g" be a "r".

Will do.

-Andi
