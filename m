Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbUJ1Gj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbUJ1Gj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbUJ1Ggb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:36:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:40330 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262811AbUJ1GdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:33:10 -0400
To: Sorav Bansal <sbansal@stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: User/Kernel Pointer bug in sys_poll
References: <20041028052218.52478.qmail@web50207.mail.yahoo.com.suse.lists.linux.kernel>
	<Pine.GSO.4.44.0410272246240.7124-100000@elaine9.Stanford.EDU.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Oct 2004 08:32:58 +0200
In-Reply-To: <Pine.GSO.4.44.0410272246240.7124-100000@elaine9.Stanford.EDU.suse.lists.linux.kernel>
Message-ID: <p73d5z31het.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorav Bansal <sbansal@stanford.edu> writes:

> Older x86 architectures (386 and before) allow the kernel to write to any
> user location regardless of the write-protect bits.

Actually it's only some early steppings of 386 and Linux never ran on
a 286 or earlier. I think the best would be to just ignore it, the affected
user base is very likely zero or very near it. I suspect the 
probability of one of these machines still used as a multiuser
machine is very definitely nil.

Cue is that 386 got occassionally broken, and it often took 
months to be noticed.

These machines already have other exploitable bugs BTW that have been
ignored for a long time and only been fixed in 2.6.

So just ignore it. It's a non issue, really.

-Andi
