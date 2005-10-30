Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVJ3SGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVJ3SGm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVJ3SGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:06:42 -0500
Received: from cantor2.suse.de ([195.135.220.15]:21987 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932141AbVJ3SGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:06:41 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <20051030105118.GW4180@stusta.de>
From: Andi Kleen <ak@suse.de>
Date: 30 Oct 2005 19:06:39 +0100
In-Reply-To: <20051030105118.GW4180@stusta.de>
Message-ID: <p73mzkqubf4.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> This patch schedules obsolete OSS drivers (with ALSA drivers that support the
> same hardware) for removal.
> 
> Scheduling the via82cxxx driver for removal was ACK'ed by Jeff Garzik.

I would prefer if the ICH driver be kept. It works just fine on near
all my systems and has a much smaller binary size than the ALSA
variant. Moving to ALSA would bloat the kernels considerably.

-Andi
