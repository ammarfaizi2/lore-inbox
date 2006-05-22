Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWEVLvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWEVLvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWEVLvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:51:22 -0400
Received: from mail.suse.de ([195.135.220.2]:44173 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750771AbWEVLvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:51:16 -0400
To: Vladimir Dvorak <dvorakv@vdsoft.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC error on CPUx
References: <44716A5F.3070208@vdsoft.org>
From: Andi Kleen <ak@suse.de>
Date: 22 May 2006 13:15:30 +0200
In-Reply-To: <44716A5F.3070208@vdsoft.org>
Message-ID: <p73k68e71kd.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Dvorak <dvorakv@vdsoft.org> writes:
> 
> Linux requisities:
> Debian 3.1
> Linux mailserver 2.6.8-3-686-smp #1 SMP Thu Feb 9 07:05:39 UTC 2006 i686

That's an ancient kernel.

> GNU/Linux
> 
> Hardware:
> Intel SR1200

If it's an <=P3 class machine: most likely you have noise on the APIC bus.

-Andi
