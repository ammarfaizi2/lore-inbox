Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTKZTxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 14:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTKZTxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 14:53:05 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:17025 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264286AbTKZTxD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 14:53:03 -0500
Date: Wed, 26 Nov 2003 19:52:45 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bruce Perens <bruce@perens.com>, Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Never mind. Re: Signal left blocked after signal handler.
Message-ID: <20031126195245.GF14383@mail.shareable.org>
References: <20031126173953.GA3534@perens.com> <Pine.LNX.4.58.0311260945030.1524@home.osdl.org> <3FC4ED5F.4090901@perens.com> <3FC4EF24.9040307@perens.com> <3FC4F248.8060307@perens.com> <Pine.LNX.4.58.0311261037370.1524@home.osdl.org> <3FC4F94F.6030801@perens.com> <Pine.LNX.4.58.0311261108350.1524@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311261108350.1524@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I personally think it is "good taste" to actually set the SA_NODEFER flag
> if you know you depend on the behaviour, but if there are lots of existing
> applications that actually depend on the "forced punch-through" behaviour,
> then I'll obviously have to change the 2.6.x behaviour (a stable
> user-level ABI is a lot more important than my personal preferences).

I also have a program which depends on the behaviour of nesting
SIGSEGVs, however luckily I already set the SA_NODEFER flag :)

-- Jamie
