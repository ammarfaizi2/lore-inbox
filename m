Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVBNVrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVBNVrU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 16:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVBNVrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 16:47:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:44219 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261567AbVBNVrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 16:47:14 -0500
Date: Mon, 14 Feb 2005 13:46:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: ncunningham@cyclades.com, bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Address lots of pending pm_message_t changes
Message-Id: <20050214134658.324076c9.akpm@osdl.org>
In-Reply-To: <20050214213400.GF12235@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au>
	<20050214213400.GF12235@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Andrew, if you get one big patch doing only type-safety (u32 ->
>  pm_message_t, no code changes), would you still take it this late? I
>  promise it is not going to break anything... It would help merge after
>  2.6.11 quite a lot...

Problem is, such a megapatch causes grief for all those people who maintain
their own trees.  It would be best, please, to split it into 10-20 bits and
send the USB parts to Greg and the SCSI bits to James, etc.
