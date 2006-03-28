Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWC1Ilo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWC1Ilo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 03:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWC1Ilo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 03:41:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8637 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751378AbWC1Iln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 03:41:43 -0500
Date: Tue, 28 Mar 2006 00:41:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: ornati@fastwebnet.it, linux-kernel@vger.kernel.org
Subject: Re: Random GCC segfaults -- Was: [2.6.16] slab error in
 slab_destroy_objs(): cache `radix_tree_node'...
Message-Id: <20060328004137.607e51db.akpm@osdl.org>
In-Reply-To: <20060328095521.52ea3424@localhost>
References: <20060326215346.1b303010@localhost>
	<20060328095521.52ea3424@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati <ornati@fastwebnet.it> wrote:
>
>  On Sun, 26 Mar 2006 21:53:46 +0200
>  Paolo Ornati <ornati@fastwebnet.it> wrote:
> 
>  > PS: I've got another "gcc segfault" trying to build Qt again after a
>  > reboot but I don't think this is a memory problem (actually I have
>  > a memory problem (single bit error) but it should be cured with
>  > memmap=1K$214014K ;).
> 
>  I've got others NON reproducible gcc segfaults, usually compiling some
>  huge CPP source.

If those errors had no corresponding kernel messages then what you have is
a classic symptom of failing memory hardware.  Suggest you grab memtest86,
run it for 24 hours.

