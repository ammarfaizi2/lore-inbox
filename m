Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271059AbUJUWqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271059AbUJUWqW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271061AbUJUWmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:42:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:48835 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271062AbUJUWlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:41:18 -0400
Date: Thu, 21 Oct 2004 15:45:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH 2.6.9] ppc32: Fix building for Motorola
 Sandpoint with O=
Message-Id: <20041021154517.72b0bc66.akpm@osdl.org>
In-Reply-To: <20041021220036.GB1532@smtp.west.cox.net>
References: <20041021220036.GB1532@smtp.west.cox.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> wrote:
>
> [ Resend since I still don't see it, Andrew can you pick this up please?
> Thanks ]
> 
> Since we directly -include $(clear_L2_L3) when needed, we need to point
> to the full path of it.

yup, I'll back out ppc-fix-build-with-o=output_dir.patch and push this one.
