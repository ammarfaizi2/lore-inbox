Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbUBYJJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 04:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbUBYJJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 04:09:08 -0500
Received: from zadnik.org ([194.12.244.90]:13270 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S262489AbUBYJJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 04:09:05 -0500
Date: Wed, 25 Feb 2004 11:08:47 +0200 (EET)
From: Grigor Gatchev <grigor@zadnik.org>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <Pine.LNX.4.44.0402241730190.21522-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0402251103470.16939-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Feb 2004, Rik van Riel wrote:

> On Tue, 24 Feb 2004, Grigor Gatchev wrote:
>
> > A Layered Kernel
> > Proposal
>
> Sounds like a reasonable description of how Linux already
> works, with the exception of badly written code that has
> layering violations.

It's not about how Linux works, but about how the kernel should work. But
you are right, the kernel is already structured in a way convenient to go
for it.

> I'm all for cleaning up the badly written code so it fits
> in better with the rest of the kernel ;)

Unhappily, cleaning up would not be enough. A separation of the kernel
layers, to the extent that one may be able to use them independently, and
to plug modules between them (having the appropriate access) may be
better.


