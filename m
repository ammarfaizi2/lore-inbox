Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUGHR05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUGHR05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 13:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUGHR05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 13:26:57 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:2571 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264012AbUGHR0z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 13:26:55 -0400
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FAT: update document
References: <87d637mxig.fsf@devron.myhome.or.jp>
	<20040707235007.GA5687@pclin040.win.tue.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 09 Jul 2004 02:26:43 +0900
In-Reply-To: <20040707235007.GA5687@pclin040.win.tue.nl>
Message-ID: <87wu1el8a4.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> writes:

> I am not in favour of introducing such configuration options.
> 
> This is just the default for a mount option. No twiddling at
> kernel configuration time is required or useful.
> 
> We have too many configuration options. It is not true that the system
> becomes better when there are more compile-time configuration possibilities.
> Quite the contrary.
> 
> Compilation options should select inclusion of subsystems,
> modules, drivers, but not twiddle behaviour.
>
> [So, I would be happier if you selected a default and made everybody who
> wants something else adapt her /etc/fstab, or alias for a mountfat command.]

Indeed.

I was forgetting the mount.fat. Probably the mount.fat can do more
good choice.

Also I think that kernel doesn't need to know about nls choice anymore
(include a default). But users may be confused temporarily...

Anyway, I'll rethink this tomorrow.

Thanks a lot.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
