Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUESKDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUESKDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 06:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUESKDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 06:03:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:65250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262322AbUESKDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 06:03:50 -0400
Date: Wed, 19 May 2004 03:03:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Eger <eger@theboonies.us>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: FB accel capabilities patch
Message-Id: <20040519030319.1f0e6eec.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us>
References: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Eger <eger@theboonies.us> wrote:
>
> A month or two ago I noticed that the framebuffer console driver doesn't
>  know to do proper framebuffer acceleration in Linux 2.6;

For what fbdev operations will acceleration be used?

> I've implemented
>  a solution Geert suggested where each framebuffer driver advertizes its 
>  hardware capabilities via fb_info->flags.  Please apply to -mm so I can 
>  get wider testing.

The larger patch gets a bunch of rejects against Linus's current tree. 
Please update and resend.

Please send the patches via email, too.  That way lots of people help to
check your code and it's considerably less fiddly at my end.

Canonical form is one patch per email, with the changelog at the top of the
email, with a useful Subject: which describes the patch.  Each patch email
will have a different subject, and that subject ain't the name of the file
which holds the patch!  The patch will be in the body of the email of your
MUA is halfway sane.  As an attachment if not.

Thanks.
