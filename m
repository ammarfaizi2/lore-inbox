Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316127AbSGASgV>; Mon, 1 Jul 2002 14:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSGASgU>; Mon, 1 Jul 2002 14:36:20 -0400
Received: from dingo.clsp.jhu.edu ([128.220.34.67]:61190 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S316127AbSGASgT>;
	Mon, 1 Jul 2002 14:36:19 -0400
Date: Mon, 1 Jul 2002 04:20:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: non-killable program - kernel problem?
Message-ID: <20020701022034.GB829@elf.ucw.cz>
References: <3D1582E4.7016EA1F@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D1582E4.7016EA1F@bigfoot.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   cleanup (part of postfix) is eating up most of CPU cycles and I cannot
> kill it (-9 is ignored) - I guess that means that the problem is
> somewhere in kernel (system call). Is it true? Is there anything I can
> do to kill it? to find out what the problem is?

Yep, that's a kernel bug. Power switch should kill it safely
;-). Magic keys may be able to show where it loops.
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
