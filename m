Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161167AbWJUAOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbWJUAOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbWJUAOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:14:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50089 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161087AbWJUAOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:14:44 -0400
Date: Fri, 20 Oct 2006 17:14:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Junio C Hamano <junkio@cox.net>
cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 1.4.3
In-Reply-To: <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net> <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Oct 2006, Junio C Hamano wrote:
> 
> I am considering the following to address irritation some people
> (including me, actually) are experiencing with this change when
> viewing a small (or no) diff.  Any objections?

Not from me. I use "git diff" just to check that the tree is empty, and 
the fact that it now throws me into an empty pager is irritating.

That said, "LESS=FRS" doesn't really help that much. It still clears the 
screen. Using "LESS=FRSX" fixes that, but the alternate display sequence 
is actually nice _if_ the pager is used.

Still, I think I'd prefer FRSX as the default.

		Linus
