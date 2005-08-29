Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVH2VYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVH2VYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 17:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVH2VYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 17:24:40 -0400
Received: from ns2.suse.de ([195.135.220.15]:62409 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751298AbVH2VXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 17:23:41 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 16/16] Add hardware breakpoint support for i386
References: <resend.15.2982005.trini@kernel.crashing.org>
	<1.2982005.trini@kernel.crashing.org>
	<resend.16.2982005.trini@kernel.crashing.org>
From: Andi Kleen <ak@suse.de>
Date: 29 Aug 2005 23:23:39 +0200
In-Reply-To: <resend.16.2982005.trini@kernel.crashing.org>
Message-ID: <p73wtm4fndw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> writes:

> This adds hardware breakpoint support for i386.  This is not as well tested as
> software breakpoints, but in some minimal testing appears to be functional.

This really would need so coordination with user space using 
them. Otherwise it'll be quite unreliable because any user program
can break it.

Long ago (in 2.4 time frame) there used to be a IBM patch floating
around to reserve them globally and user space to use specific ones. I
guess something like that would be needed again.

-Andi

