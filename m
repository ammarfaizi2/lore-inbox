Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUG1XsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUG1XsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267351AbUG1Xq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:46:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:36307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267344AbUG1Xp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:45:58 -0400
Date: Wed, 28 Jul 2004 16:49:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm1 link errors
Message-Id: <20040728164920.5ad4c114.akpm@osdl.org>
In-Reply-To: <1091057256.2871.637.camel@nighthawk>
References: <1091057256.2871.637.camel@nighthawk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> I'm getting some odd link errors from -rc2-mm1 that don't happen in
> -rc1-mm1, or plain -rc2:
> 
>           LD      .tmp_vmlinux1
>         ldchk: .tmp_vmlinux1: final image has undefined symbols:
>         
>         
>         <bunch of blank lines>
>         
>         
>         make: *** [.tmp_vmlinux1] Error 1
>         
> Any ideas?

Nope.   Could you take a look at the code in the top-level
Makefile which is doing this, work out why it broke?
