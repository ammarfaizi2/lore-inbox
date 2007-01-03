Return-Path: <linux-kernel-owner+w=401wt.eu-S1754996AbXACHwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbXACHwL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754998AbXACHwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:52:11 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57768 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996AbXACHwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:52:10 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Jean Delvare <khali@linux-fr.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] i386 kernel instant reboot with older binutils fix
References: <20070103041645.GA17546@in.ibm.com>
	<m1tzz8k3sd.fsf@ebiederm.dsl.xmission.com>
	<20070103065538.GD17546@in.ibm.com>
Date: Wed, 03 Jan 2007 00:50:25 -0700
In-Reply-To: <20070103065538.GD17546@in.ibm.com> (Vivek Goyal's message of
	"Wed, 3 Jan 2007 12:25:38 +0530")
Message-ID: <m1ejqck0qm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> Hi Eric,
>
> This .text.head section is not part of vmlinux. This is part of uncompressed
> portion in bzImage. arch/i386/boot/compressed/head.S.
>
> Hence, arch/i386/boot/compressed/vmlinux.lds should take care of it which
> already has entry for linking .text.head section.

Yep.  Sorry never mind.

Thanks for the good tracking on this one.  

Eric
