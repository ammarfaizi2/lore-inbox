Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267785AbTAMDu7>; Sun, 12 Jan 2003 22:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267789AbTAMDu7>; Sun, 12 Jan 2003 22:50:59 -0500
Received: from users.ccur.com ([208.248.32.211]:44674 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S267785AbTAMDu6>;
	Sun, 12 Jan 2003 22:50:58 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200301130359.DAA18113@rudolph.ccur.com>
Subject: Re: [PATCH] some large create_module(2) sizes can oops a kernel
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Sun, 12 Jan 2003 22:59:41 -0500 (EST)
Cc: joe.korty@ccur.com (Joe Korty), linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <20030113031023.213EC2C06A@lists.samba.org> from "Rusty Russell" at Jan 13, 2003 01:34:43 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about removing the BUG() from vmalloc.c, like 2.5 has done?

I was erring on the safe side of assuming the BUG was useful for
detecting internal (non-user) erronous uses of vmalloc.  However
if that is not an issue then removing the BUG is best.

Joe
