Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131320AbRDBWAA>; Mon, 2 Apr 2001 18:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131362AbRDBV7u>; Mon, 2 Apr 2001 17:59:50 -0400
Received: from ns.suse.de ([213.95.15.193]:35086 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131320AbRDBV7l>;
	Mon, 2 Apr 2001 17:59:41 -0400
To: "J . A . Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] multiline string cleanup
In-Reply-To: <20010330234804.A27780@werewolf.able.es>
From: Andi Kleen <ak@suse.de>
Date: 02 Apr 2001 23:57:30 +0200
In-Reply-To: "J . A . Magallon"'s message of "30 Mar 2001 23:53:32 +0200"
Message-ID: <oupd7avyng5.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" <jamagallon@able.es> writes:

> This is one other try to make kernel sources gcc-3.0 friendly. This cleans
> some muti-line asm strings in checksum.h and floppy.h (this were the only
> ones reported in my kernel build, perhaps there are more in drivers I do
> not use).

I surely hope the gcc guys will just remove that silly warning again, because
it makes it impossible to write readable inline assembly now.

-Andi
