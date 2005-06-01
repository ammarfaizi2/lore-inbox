Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVFAIUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVFAIUl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 04:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVFAIUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 04:20:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41658 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261278AbVFAIU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 04:20:27 -0400
Date: Wed, 1 Jun 2005 10:13:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] Add some hooks to generic suspend code
Message-ID: <20050601081336.GA6693@elf.ucw.cz>
References: <1117524577.5826.35.camel@gaston> <20050531101344.GB9614@elf.ucw.cz> <1117550660.5826.42.camel@gaston> <20050531212556.GA14968@elf.ucw.cz> <1117582309.5826.60.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117582309.5826.60.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Why do you need it? Do you initiate suspend without userland asking
> > you to?
> 
> Because there is an existing API, via /dev/apm_bios, and that's all X
> understands ! And because I've always done that ;)

Try stopping doing that ;-).

[On i386, we do not emulate apm, and it still works. Reason is that we
switch to other console before suspend, so X has to give up
framebuffer control, anyway.]

								Pavel
