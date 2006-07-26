Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWGZRlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWGZRlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbWGZRlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:41:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43431 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161001AbWGZRlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:41:07 -0400
Date: Wed, 26 Jul 2006 10:41:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Nasty git corruption problem
In-Reply-To: <Pine.LNX.4.63.0607261935160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Message-ID: <Pine.LNX.4.64.0607261039380.29649@g5.osdl.org>
References: <1153929715.13509.12.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607260945440.29649@g5.osdl.org>
 <Pine.LNX.4.63.0607261935160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Jul 2006, Johannes Schindelin wrote:
>
> We _do_ have git-lost-found.sh.

Yeah, sure, I knew that, I was just checking who was awake..

I think the "git-fsck-objects --lost-n-found" patch may be nicer, though. 
Of course, only if somebody also adds some documentation to it, so that 
people can actually see that it is there.

		Linus
