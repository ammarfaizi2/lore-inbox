Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWGBVhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWGBVhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 17:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWGBVhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 17:37:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26020 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750830AbWGBVhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 17:37:14 -0400
Date: Sun, 2 Jul 2006 14:36:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: pageexec@freemail.hu
cc: Chuck Ebbert <76306.1226@compuserve.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] i386: clean up user_mode() use
In-Reply-To: <44A85518.24327.2FBD646A@pageexec.freemail.hu>
Message-ID: <Pine.LNX.4.64.0607021433320.12404@g5.osdl.org>
References: <200607021612_MC3-1-C3FD-CC89@compuserve.com>
 <44A85518.24327.2FBD646A@pageexec.freemail.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Jul 2006, pageexec@freemail.hu wrote:
> 
> the fact that arch *independent* code makes use of user_mode() was
> apparently lost on you.

Argh. Yes, there's one single use, apparently.

Sad.

		Linus
