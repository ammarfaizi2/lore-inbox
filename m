Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbWBGS4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWBGS4K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 13:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWBGS4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 13:56:10 -0500
Received: from [198.99.130.12] ([198.99.130.12]:2694 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932216AbWBGS4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 13:56:09 -0500
Date: Tue, 7 Feb 2006 13:57:07 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Ulrich Drepper <drepper@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/8] UML - Define jmpbuf access constants
Message-ID: <20060207185707.GB6841@ccure.user-mode-linux.org>
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org> <a36005b50602070937h60e35294q1dbef2c21f2fb50d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50602070937h60e35294q1dbef2c21f2fb50d@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 09:37:13AM -0800, Ulrich Drepper wrote:
> I assume you have your own setjmp implementation and are not using the
> libc version?

Nope, that would be the next step if this turned out to be untenable,
which I guess it is.

> If you don't then there is a problem.  There is a good reason why the
> constants are removed: you couldn't use the values anyway.  Your don't
> have the information to "decrypt" them.  

You're actually encrypting them somehow?  How?  And why?

Is there a reason there can't be an API for looking at the contents of
a jmp_buf?

				Jeff
