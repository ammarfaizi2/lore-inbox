Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbTDVCjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 22:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTDVCjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 22:39:12 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:7132 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S262856AbTDVCjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 22:39:11 -0400
Date: Tue, 22 Apr 2003 03:43:27 +0100 (BST)
From: Jon Masters <jonathan@jonmasters.org>
To: Jon Masters <jonathan@jonmasters.org>
cc: linux-kernel@vger.kernel.org, jcm@jonmasters.org
Subject: Re: PPC ELF Runtime Relocation
In-Reply-To: <Pine.LNX.4.10.10304220231380.2862-100000@router>
Message-ID: <Pine.LNX.4.10.10304220338440.2862-100000@router>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003, Jon Masters wrote:

> I need some advice on some specifics of arch/ppc/kernel/setup.c

Having said that and typically of situations in which one asks for advice,
I realised the solution of using -mrelocatable-lib and something similar
to reloc_got2. Either I am missing some documentation somewhere or I could
perhaps write this down at some point to help the next guy decipher it.

I knew what the got2 section was and why it needed to be relocated but not
how to generate it! :-) Anyway it works with gcc3 and so I am happy.

Cheers,

Jon.

