Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbUAHEND (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 23:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbUAHEND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 23:13:03 -0500
Received: from pD95268A8.dip.t-dialin.net ([217.82.104.168]:35527 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S263636AbUAHENB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 23:13:01 -0500
To: Dave Jones <davej@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Use of floating point in the kernel
From: Andi Kleen <ak@muc.de>
Date: Thu, 08 Jan 2004 05:12:51 +0100
In-Reply-To: <1bzv7-4Cw-3@gated-at.bofh.it> (Dave Jones's message of "Thu,
 08 Jan 2004 05:00:13 +0100")
Message-ID: <m3hdz79iyk.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <1bvUw-7Ry-15@gated-at.bofh.it> <1bzbF-4cG-5@gated-at.bofh.it>
	<1bzv7-4Cw-3@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> On Wed, Jan 07, 2004 at 07:34:06PM -0800, H. Peter Anvin wrote:
>
>  > Has anyone considered asking the gcc people to add an -fno-fpu (or 
>  > -mno-fpu) option, throwing an error if any FP instructions are used?
>
> building with -msoft-float gets you this.

I think they will need an -fno-fpu option for the kernel at some point
anyways. As soon as gcc starts using SSE2 registers for integer
operations on SSE2 targets. My impression is that this point isn't
that far away anymore.

-Andi
