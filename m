Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281878AbRK1E1S>; Tue, 27 Nov 2001 23:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281879AbRK1E1I>; Tue, 27 Nov 2001 23:27:08 -0500
Received: from zero.tech9.net ([209.61.188.187]:21002 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281870AbRK1E1B>;
	Tue, 27 Nov 2001 23:27:01 -0500
Subject: Re: heads-up: preempt kernel and tux NO-GO
From: Robert Love <rml@tech9.net>
To: J Sloan <jjs@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C043B11.2FA17A19@pobox.com>
In-Reply-To: <3C043B11.2FA17A19@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 27 Nov 2001 23:27:32 -0500
Message-Id: <1006921653.824.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-27 at 20:17, J Sloan wrote:

> So, there is an issue with tux and the preempt
> patch - I've got big plans for tux atm, so for
> now I will have to do without preempt -

Tux makes heavy use of per-CPU data and some of it is undoubtedly not
preempt-safe.  It is probably trivial to fix but would take some
familiarity with the codebase...Ingo would know best.  Its not on the
top of my todo list, but I will look into it. 

	Robert Love

