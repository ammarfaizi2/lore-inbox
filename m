Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbTEGVTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 17:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264243AbTEGVTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 17:19:14 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:63220 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S264242AbTEGVTM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 17:19:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Jonathan Lundell <linux@lundell-bros.com>,
       =?iso-8859-1?q?root=40chaos=2Eanalogic=2Ecom=2CJ=F6rn=20Engel?= 
	<joern@wohnheim.fh-wedel.de>
Subject: Re: top stack (l)users for 2.5.69
Date: Wed, 7 May 2003 16:30:50 -0500
X-Mailer: KMail [version 1.2]
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]>
In-Reply-To: <p05210601badeeb31916c@[207.213.214.37]>
MIME-Version: 1.0
Message-Id: <03050716305002.07468@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 12:13, Jonathan Lundell wrote:
[snip]
> One thing that would help (aside from separate interrupt stacks)
> would be a guard page below the stack. That wouldn't require any
> physical memory to be reserved, and would provide positive indication
> of stack overflow without significant runtime overhead.

It does take up a page table entry, which may also be in short supply
