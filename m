Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVFUOtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVFUOtr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVFUOtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:49:47 -0400
Received: from gate.perex.cz ([82.113.61.162]:58303 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261478AbVFUOtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:49:45 -0400
Date: Tue, 21 Jun 2005 16:49:43 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adrian Bunk <bunk@stusta.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: ALSA: Is CONFIG_SND_DEBUG_MEMORY really required?
In-Reply-To: <20050621144041.GP3666@stusta.de>
Message-ID: <Pine.LNX.4.58.0506211643080.18102@pnote.perex-int.cz>
References: <20050621144041.GP3666@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Adrian Bunk wrote:

> Hi,
> 
> I was a bit surprised to discover that ALSA has it's own memory 
> debugging infrastructure.
> 
> Is there a reason why CONFIG_DEBUG_SLAB isn't good enough for ALSA?

We're ready to move to something other, but standard allocation 
routines should be extended to handle "allocation pools".

We're able to detect quickly memory leaks in our code.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
