Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUAHBku (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUAHBkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:40:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:45962 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263325AbUAHBks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:40:48 -0500
Date: Wed, 7 Jan 2004 17:40:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 fix for mremap is incorrect?
In-Reply-To: <3FFC5D5E.8040303@stud.feec.vutbr.cz>
Message-ID: <Pine.LNX.4.58.0401071740000.12602@home.osdl.org>
References: <3FFC5D5E.8040303@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Jan 2004, Michal Schmidt wrote:
> 
> I think that your fix doesn't prevent these degenerate cases from 
> happening.

Yeah, I'm an idiot. That's what you get for not actually testing your 
patches. Thanks.

		Linus
