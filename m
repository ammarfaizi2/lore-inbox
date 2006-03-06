Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWCFNPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWCFNPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWCFNPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:15:47 -0500
Received: from cantor2.suse.de ([195.135.220.15]:63878 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932233AbWCFNPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:15:46 -0500
Message-ID: <440C363F.8000503@suse.de>
Date: Mon, 06 Mar 2006 14:16:47 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ELF entry point (i386)
References: <43FC4682.6050803@suse.de> <m1bqwkc0l1.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1bqwkc0l1.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> We load the kernel at physical addresses and we enter
> the kernel at a physical address.  Even the entry point
> expects that.
> 
> Is there some reason you think the entry point is virtual?

Elf specs say so.  The paragraph in question mentions processes not OS
kernels though ...

cheers,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg
