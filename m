Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTD1MRf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 08:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTD1MRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 08:17:35 -0400
Received: from ns.suse.de ([213.95.15.193]:21005 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263540AbTD1MRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 08:17:34 -0400
To: Andreas Jaeger <aj@suse.de>
Cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
Subject: Re: ia32 kernel on amd64 box?
References: <20030425214500.GA20221@ncsu.edu.suse.lists.linux.kernel>
	<hoof2rghbs.fsf@byrd.suse.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Apr 2003 14:29:29 +0200
In-Reply-To: <hoof2rghbs.fsf@byrd.suse.de.suse.lists.linux.kernel>
Message-ID: <p734r4i4xg6.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jaeger <aj@suse.de> writes:

> Any 32-bit x86 kernel should work on an AMD Opteron machine.  The only
> question is whether all drivers are supported.  Red Hat 7.2 might not
> have support for all the hardware that is in an AMD Opteron ystem.

Actually some things will not work with older kernels because the
Linux kernel does explicit CPUID model checks in a few places. But it
is relative obscure stuff and unlikely to be a problem in
practice.

-Andi
