Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271040AbUJUW4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271040AbUJUW4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271045AbUJUWq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:46:57 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:57742 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S271048AbUJUWnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:43:37 -0400
Date: Thu, 21 Oct 2004 15:43:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH 2.6.9] ppc32: Fix building for Motorola Sandpoint with O=
Message-ID: <20041021224331.GC1532@smtp.west.cox.net>
References: <20041021220036.GB1532@smtp.west.cox.net> <20041021154517.72b0bc66.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021154517.72b0bc66.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 03:45:17PM -0700, Andrew Morton wrote:
> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> > [ Resend since I still don't see it, Andrew can you pick this up please?
> > Thanks ]
> > 
> > Since we directly -include $(clear_L2_L3) when needed, we need to point
> > to the full path of it.
> 
> yup, I'll back out ppc-fix-build-with-o=output_dir.patch and push this one.

OK.  Just so we're clear, these are different issues.

-- 
Tom Rini
http://gate.crashing.org/~trini/
