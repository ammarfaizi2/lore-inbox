Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281029AbRKGWa5>; Wed, 7 Nov 2001 17:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281022AbRKGWah>; Wed, 7 Nov 2001 17:30:37 -0500
Received: from zero.tech9.net ([209.61.188.187]:23312 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281024AbRKGWad>;
	Wed, 7 Nov 2001 17:30:33 -0500
Subject: Re: disaster with 2.4.14+preempt
From: Robert Love <rml@tech9.net>
To: J Sloan <jjs@lexus.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BE9A506.82D64AE4@lexus.com>
In-Reply-To: <3BE8B460.A23E1A67@pobox.com> <1005109646.884.0.camel@phantasy>
	 <3BE9A506.82D64AE4@lexus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 07 Nov 2001 17:30:36 -0500
Message-Id: <1005172239.939.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-07 at 16:17, J Sloan wrote:
> Is there anything in particular you would
> like me to try?

Confirm 2.4.13+preempt doesn't cause the problem.

If it doesn't, can you try recompiling with the newest 2.4.13
preempt-kernel patch.  I forget from which version we removed the atomic
operators, but I want to confirm this is not the problem.

Confirm 2.4.14 doesn't cause the problem.

(if possible) confirm 2.4.14+preempt does indeed cause the problem.

Let me just spit out my thinking here:

	Is it preempt?
		Is it something in 2.4.14 annoying preempt?
		Is it the non-atomicity recently introduced?		

	Robert Love

