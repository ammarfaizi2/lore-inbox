Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVC1Pdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVC1Pdv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 10:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVC1PbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 10:31:16 -0500
Received: from one.firstfloor.org ([213.235.205.2]:7869 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261900AbVC1P1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 10:27:51 -0500
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2.6.12-rc1-mm2] x86_64: fix vsyscall.c syntax error
References: <200503241842.j2OIg3fa011988@harpo.it.uu.se>
From: Andi Kleen <ak@muc.de>
Date: Mon, 28 Mar 2005 17:27:50 +0200
In-Reply-To: <200503241842.j2OIg3fa011988@harpo.it.uu.se> (Mikael
 Pettersson's message of "Thu, 24 Mar 2005 19:42:03 +0100 (MET)")
Message-ID: <m1is3b3i4p.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

Can you please cc me on all x86-64 patches?


> Compiling 2.6.12-rc1-mm2 on x86_64 with gcc-4.0 fails with:
>
> arch/x86_64/kernel/vsyscall.c:193: error: syntax error before 'vsyscall_sysctl_change'
>
> Fix: repair the syntax error

Looks ok thanks. I wish gcc folks wouldnt change the language in
each revision like this.

-Andi
