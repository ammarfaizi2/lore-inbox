Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992516AbWJTV5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992516AbWJTV5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992779AbWJTV5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:57:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8617 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S2992516AbWJTV5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:57:44 -0400
Message-ID: <45394615.5050406@redhat.com>
Date: Fri, 20 Oct 2006 16:56:37 -0500
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] more helpful WARN_ON and BUG_ON messages
References: <4538F81A.2070007@redhat.com> <20061020214101.GX3502@stusta.de>
In-Reply-To: <20061020214101.GX3502@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> Who really needs this considering it implies a size increase of the 
> kernel image?
> 
> Using a kernel tree so unusual that you can't locate the source anymore 
> sounds like an extremely rare and unintelligent situation, not something 
> that must be handled.

Most debugging code makes the kernel bigger, slower... and easier to
debug, no?

It's not a question of not being -able- to locate sources; it's a
question of being able to look at a bug report and triage it quickly
without digging around to find the kernel du jour that produced it.  *shrug*

-Eric
