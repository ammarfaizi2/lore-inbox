Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282988AbRLGQsO>; Fri, 7 Dec 2001 11:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282998AbRLGQrp>; Fri, 7 Dec 2001 11:47:45 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:25098 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S283003AbRLGQqv>; Fri, 7 Dec 2001 11:46:51 -0500
Date: Fri, 7 Dec 2001 16:03:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Chris Wedgwood <cw@f00f.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
Message-ID: <20011207160347.A1404@elf.ucw.cz>
In-Reply-To: <E16BkER-0006J0-00@wagner> <20011206091836.GA5470@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011206091836.GA5470@weta.f00f.org>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Thu, Dec 06, 2001 at 09:09:35AM +1100, Rusty Russell wrote:
> 
>     The following patch implements convenient per-cpu areas:
>         DECLARE_PER_CPU(int myvar);
> 
> Where or why do we need this?

DECLARE_PER_CPU(struct task *current). Same for slab quick-alloc
lists, performance counters,  ...
							Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
