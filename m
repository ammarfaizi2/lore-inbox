Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVJXTf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVJXTf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 15:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVJXTfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 15:35:55 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:48132 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751145AbVJXTfz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 15:35:55 -0400
Date: Mon, 24 Oct 2005 15:28:11 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       blaisorblade@yahoo.it
Subject: Re: [PATCH resend] uml: fix compile failure for TT mode
Message-ID: <20051024192811.GA6962@ccure.user-mode-linux.org>
References: <E1EU4Zq-0005jq-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EU4Zq-0005jq-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 05:49:34PM +0200, Miklos Szeredi wrote:
> Without this patch, uml compile fails with:
> 
>   LD      .tmp_vmlinux1
> arch/um/kernel/built-in.o: In function `config_gdb_cb':
> arch/um/kernel/tt/gdb.c:129: undefined reference to `TASK_EXTERN_PID'
> 
> Tested on i386, but fix needed on x86_64 too AFAICS.
> 
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Acked-by: Jeff Dike <jdike@addtoit.com>

				Jeff
