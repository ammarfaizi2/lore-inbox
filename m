Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbULVS16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbULVS16 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 13:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbULVS1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 13:27:41 -0500
Received: from holomorphy.com ([207.189.100.168]:21425 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262011AbULVSZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 13:25:53 -0500
Date: Wed, 22 Dec 2004 10:25:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Regis Leclerc <regis@safety-host.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-source bug for sparc architecture
Message-ID: <20041222182544.GV771@holomorphy.com>
References: <1103739302.21581.11.camel@smaug.safetyhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103739302.21581.11.camel@smaug.safetyhost.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 07:15:02PM +0100, Regis Leclerc wrote:
> I am compiling kernel 2.6.9 on a sparc32 architecture (SUN4C) with
> GCC3.3.4, and found that drivers/video/bw2.c has a compilation problem
> on line 389.
> There is a call that passes &options as 2nd argument, but the "options"
> variable isn't defined anywhere.
> In drivers/video/cg6.c there is the same kind of call, but it passes
> NULL instead of &options, so I altered bw2.c to replace &options with
> NULL, so the compilation can go on (it's a part of the make image part).
> I am not a specialist of video drivers on sparc32 (I have a CG6,
> anyway), but I'm reporting this compilation problem so a true specialist
> of this part of the code can raise an eyebrow on it.

I've seen a patch for that, but wasn't sure if I should take on a video
driver as it's outside of arch/sparc/. If it's not already merged, it
will be in a sparc32 release I'll announce later on today.


-- wli
