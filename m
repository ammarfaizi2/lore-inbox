Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbTGCK1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 06:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265933AbTGCK1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 06:27:51 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:43153 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S265932AbTGCK1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 06:27:50 -0400
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (trivial 2.5.74) compilation fix
 drivers/mtd/mtd_blkdevs.c
References: <7vbrwc3sxo.fsf@assigned-by-dhcp.cox.net>
	<86llvgkk59.fsf@trasno.mitica>
From: junkio@cox.net
Date: Thu, 03 Jul 2003 03:42:15 -0700
In-Reply-To: <86llvgkk59.fsf@trasno.mitica> (Juan Quintela's message of
 "Thu, 03 Jul 2003 11:57:22 +0200")
Message-ID: <7v7k6z51tk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JQ" == Juan Quintela <quintela@mandrakesoft.com> writes:

>>>>> "junkio" == junkio  <junkio@cox.net> writes:
junkio> C does not let us declare variables in the middle of a block (yet).

JQ> It depends what do you call C :)
JQ> C99 does.

That is an inappropriate comment in this list.  As far as the
kernel code is concerned, Documentation/Changes defines what C
is :-), and it says "GCC 2.95.3 or later".

Since 2.95.3 does not support declaration-in-the-middle,
decl-in-the-middle is not a valid C (yet).  On the other hand,
other C99 extentions that compiler can grok (e.g. '.FIELDNAME ='
style initializer) is now already part of valid C :-).

