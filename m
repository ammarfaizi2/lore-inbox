Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287089AbSABWcY>; Wed, 2 Jan 2002 17:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287069AbSABWcQ>; Wed, 2 Jan 2002 17:32:16 -0500
Received: from fep02.swip.net ([130.244.199.130]:42694 "EHLO
	fep02-svc.swip.net") by vger.kernel.org with ESMTP
	id <S287084AbSABWcC>; Wed, 2 Jan 2002 17:32:02 -0500
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] scheduler fixups ...
In-Reply-To: <Pine.LNX.4.40.0201021236390.1034-100000@blue1.dev.mcafeelabs.com>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Jan 2002 23:31:04 +0100
In-Reply-To: <Pine.LNX.4.40.0201021236390.1034-100000@blue1.dev.mcafeelabs.com>
Message-ID: <m28zbgpeqf.fsf@pengo.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:

> a still lower ts

This also lowers the effectiveness of nice values. In 2.5.2-pre6, if I
run two cpu hogs at nice values 0 and 19 respectively, the niced task
will get approximately 20% cpu time (on x86 with HZ=100) and this
patch will give even more cpu time to the niced task. Isn't 20% too
much?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
