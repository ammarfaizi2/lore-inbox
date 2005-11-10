Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbVKJDuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbVKJDuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 22:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbVKJDuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 22:50:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30138 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751047AbVKJDuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 22:50:03 -0500
Date: Wed, 9 Nov 2005 19:49:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fix ptrace self-attach rule
In-Reply-To: <20051110004100.BDE06180A3A@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.64.0511091949230.4627@g5.osdl.org>
References: <20051110004100.BDE06180A3A@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Nov 2005, Roland McGrath wrote:
>
> I think this does affect some real programs out there.  I'm not advocating
> using ptrace on other threads in your thread group, but people have been
> doing it.  We know because that's how some of the pathological cases have
> come up that we've had to do fixes for.  Ruling it out may make these
> people unhappy, though I hope that we will have better ways for them to do
> whatever it is they really need.  Just FYI.

Ok, thanks. Let's see who hollers.

		Linus
