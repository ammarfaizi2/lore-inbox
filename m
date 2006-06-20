Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWFTAef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWFTAef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 20:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWFTAef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 20:34:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58498 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964886AbWFTAee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 20:34:34 -0400
Date: Mon, 19 Jun 2006 17:37:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: <ravinandan.arakali@neterion.com>
Cc: tglx@linutronix.de, dgc@sgi.com, mingo@elte.hu, neilb@suse.de,
       jblunck@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
       balbir@in.ibm.com, ananda.raju@neterion.com,
       leonid.grossman@neterion.com, Jes Sorensen <jes@trained-monkey.org>
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries
 list (2nd version)
Message-Id: <20060619173712.1144b332.akpm@osdl.org>
In-Reply-To: <000101c693c6$a46c5a90$3e10100a@pc.s2io.com>
References: <20060619040110.03b39673.akpm@osdl.org>
	<000101c693c6$a46c5a90$3e10100a@pc.s2io.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ravinandan Arakali" <ravinandan.arakali@neterion.com> wrote:
>
> This is a known problem and has been fixed in our internal source tree. We
> will be submitting the patch soon.

Please send me a copy asap - I urgently need to get the -mm patches vaguely
stabilised.

I'm somewhat surprised that the sn2 failed so seriously - I thought Jes was
testing that fairly regularly.

I think we kinda-sorta have a handle on the s2io->IRQ problem (although the
unexpectedly-held console spinlock is a mystery).

The scsi->BIO->mempool->slab crash is also a mystery.

Thanks.
