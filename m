Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTKNQet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 11:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTKNQet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 11:34:49 -0500
Received: from dsl092-073-159.bos1.dsl.speakeasy.net ([66.92.73.159]:32264
	"EHLO yupa.krose.org") by vger.kernel.org with ESMTP
	id S262765AbTKNQei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 11:34:38 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Why "PCI: Cannot allocate resource region..."?
X-Home-Page: http://www.krose.org/~krose/
From: Kyle Rose <krose@krose.org>
Organization: krose.org
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 14 Nov 2003 11:34:34 -0500
Message-ID: <87he16sycl.fsf@nausicaa.krose.org>
User-Agent: Gnus/5.090024 (Oort Gnus v0.24) XEmacs/21.4 (Reasonable
 Discussion, linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't get any response to my previous query, so I figured I'd ask a
simpler question: why would the kernel say that it cannot allocate a
memory-mapped I/O resource?

I looked at /proc/iomem, and none of the regions in question overlap
with any other device's regions, which presumably means the BIOS is
doing a good job configuring the devices.  So, again: for what reasons
*does* the kernel decide it can't do the allocation?  This would
greatly help my debugging efforts.

Thanks,
Kyle
