Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVCTEk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVCTEk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 23:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVCTEk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 23:40:57 -0500
Received: from pat.uio.no ([129.240.130.16]:59887 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261522AbVCTEkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 23:40:51 -0500
Subject: Re: [PATCH 2.6.11.2][RFC] printk with anti-cluttering-feature
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0503200528520.2804@be1.lrz>
References: <Pine.LNX.4.58.0503200528520.2804@be1.lrz>
Content-Type: text/plain
Date: Sat, 19 Mar 2005 23:40:33 -0500
Message-Id: <1111293634.10775.25.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.814, required 12,
	autolearn=disabled, AWL 1.01, FORGED_RCVD_HELO 0.05,
	SUBJ_HAS_UNIQ_ID 1.12, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 20.03.2005 Klokka 05:37 (+0100) skreiv Bodo Eggert:
> (I hope I avoided all spam-keywords this time, my previous mails didn't 
>  seem to make it)
> (please CC me on reply)
> 
> Issue:
> 
> On some conditions, the dmesg is spammed with repeated warnings about the
> same issue which is neither critical nor going to be fixed. This may
> result in losing the boot messages or missing other important messages.
> 
> Examples are:
> 
> nfs warning: mount version older than kernel
>  (my mount is newer than documented to be required)

Throw that one out, please. We have a more complete fix already queued
up on

http://client.linux-nfs.org/Linux-2.6.x/2.6.12-rc1/linux-2.6.12-02-kill_bad_mount_options.dif

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

