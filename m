Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVF0U35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVF0U35 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVF0U1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:27:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23434 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261665AbVF0U0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:26:16 -0400
Date: Mon, 27 Jun 2005 13:26:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Checkpoint lists split
Message-Id: <20050627132647.5c21eeba.akpm@osdl.org>
In-Reply-To: <20050627142328.GM20512@atrey.karlin.mff.cuni.cz>
References: <20050627142328.GM20512@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:
>
>  I've noticed that the patch splitting transaction's t_checkpoint_list
> into two lists (one for buffers to-be-submitted and one for already
> submitted buffers) is not in -mm kernels. Is there any reason why you've
> dropped it? If you just missed the version that fixed the bug or some
> similar mistake happened then please put the patch into -mm (it's
> attached and applies fine against 2.6.12-mm2).

It's still sitting in my to-apply folder, so it isn't lost.  The first
version was a bit traumatic, so I was holding off until I have time to do a
bunch of filesystem testing..
