Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUAHSnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUAHSmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:42:54 -0500
Received: from bender.bawue.de ([193.7.176.20]:40649 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S265886AbUAHSlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:41:16 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fixing 2.6.0's broken documentation references
In-Reply-To: <20031227160834.2de6401d.akpm@osdl.org> (Andrew Morton's
 message of "Sat, 27 Dec 2003 16:08:34 -0800")
References: <864qvmjtez.fsf@n-dimensional.de>
	<20031227160834.2de6401d.akpm@osdl.org>
From: Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Date: Thu, 08 Jan 2004 19:36:31 +0100
Message-ID: <86vfnm5lu8.fsf@n-dimensional.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Hans Ulrich Niedermann <linux-kernel@n-dimensional.de> wrote:

>> 1. How to consistently reference to doc files?

>>    c) "Documentation/"

> Yes, c).

OK, I did that. Patches against 2.6.1-rc3 in separate mails.

I split the changes into two patches:

1. The Documentation/ part.
   - Only changes documentation files.
   - No conflicts with code patches possible.

2. The code comment part.
   - Changes *.c, *.h, Kconfig and relates files.
   - May cause conflicts with code patches.

Regards,

Uli
