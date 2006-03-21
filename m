Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWCUWwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWCUWwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWCUWwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:52:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3508 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964880AbWCUWwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:52:13 -0500
Date: Tue, 21 Mar 2006 14:52:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Andrew Morton <akpm@osdl.org>, mchehab@infradead.org,
       abraham.manu@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix dvb build
In-Reply-To: <20060321221949.GA24322@havoc.gtf.org>
Message-ID: <Pine.LNX.4.64.0603211448190.3622@g5.osdl.org>
References: <20060321221949.GA24322@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2006, Jeff Garzik wrote:
> 
> Fixes 'allmodconfig' build in current git

Hmm. That's just a revert of 08f1d0b:

	V4L/DVB (3543): Fix Makefile to adapt to bt8xx/ conversion

which seems to be a premature Makefile fix for a bt8xxx/ conversion that 
hasn't even happened yet in the main tree.

I'll revert that commit for now.

		Linus
