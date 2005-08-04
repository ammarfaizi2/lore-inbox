Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVHDWQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVHDWQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbVHDWOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:14:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:29629 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262771AbVHDWMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:12:19 -0400
To: dth@picard.cistron.nl (Danny ter Haar)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5-git2 does not boot on (my) amd64
References: <dctuso$tl$1@news.cistron.nl.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Aug 2005 00:12:13 +0200
In-Reply-To: <dctuso$tl$1@news.cistron.nl.suse.lists.linux.kernel>
Message-ID: <p73iryl73nm.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dth@picard.cistron.nl (Danny ter Haar) writes:

> This is as far as it comes:
> 
> 
> Freeing unused kernel memory: 248k freed
> VM: killing process hotplug
> VM: killing process hotplug
> VM: killing process hotplug
> VM: killing process hotplug
> Unable to handle kernel paging request at fffffff28017b5be RIP:
> [<fffffff28017b5be>]

Looks weird. Just to make sure can you do a make distclean and try
again? It might be a bad compile.

-Andi
