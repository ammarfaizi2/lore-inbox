Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTKRN4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTKRNm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:42:28 -0500
Received: from ns.suse.de ([195.135.220.2]:60113 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262683AbTKRNmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:42:17 -0500
To: Joseph Pingenot <trelane@digitasaru.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA64/x86-64 and execution protection support?
References: <20031103144932.GC31953@digitasaru.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Nov 2003 21:20:24 +0100
In-Reply-To: <20031103144932.GC31953@digitasaru.net.suse.lists.linux.kernel>
Message-ID: <p738ymx8arb.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Pingenot <trelane@digitasaru.net> writes:

> Does the Linux kernel have support for preventing execution of certain
>   memory regions on those architectures?
> Also, I know that some implementations of x86 stack protection are out there;
>   I've not seen them in the vanilla kernels; is there any plan to implement
>   them?

The x86-64 port supports no-execution for stack and heap and other
memory areas, but it is not enabled by default because it breaks some 
software. You can enable it with the noexec= boot parameter. See 
Documentation/x86_64/boot-options.txt for details.

-Andi
