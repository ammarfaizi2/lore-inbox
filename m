Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWAKLMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWAKLMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 06:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWAKLMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 06:12:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:38636 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751430AbWAKLMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 06:12:52 -0500
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: Crash with SMP on post 2.6.15 -git kernel
Date: Wed, 11 Jan 2006 12:12:40 +0100
User-Agent: KMail/1.8.2
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
References: <20060110165457.42ed2087@dxpl.pdx.osdl.net> <20060110184903.790d1a2c@localhost.localdomain> <20060111093212.GA15281@in.ibm.com>
In-Reply-To: <20060111093212.GA15281@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601111212.40989.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 January 2006 10:32, Vivek Goyal wrote:

> Few x86_64 APIC related kexec changes are still in Andi's tree and have not
> been pushed to Linus tree. So there are no new x86_64 kexec patches in latest
> git repository.
> 
> Andrew has pushed x86_64 kdump related patches to Linus tree. And these become
> effective only under CONFIG_CRASH_DUMP. These patches are very less likely
> to botch with this stuff.

Yes, it was only a very quick look through the change log. Sorry for
hitting on you. I have no clue what could have broken. And my machines boot 
too with -git7 and his config.

Stephen, can you please do a binary search?

-Andi
