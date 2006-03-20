Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWCTMT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWCTMT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 07:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWCTMT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 07:19:27 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:7360 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932246AbWCTMT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 07:19:27 -0500
To: matthew@wil.cx
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <20060320121107.GE8980@parisc-linux.org> (message from Matthew
	Wilcox on Mon, 20 Mar 2006 05:11:07 -0700)
Subject: Re: DoS with POSIX file locks?
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu> <20060320121107.GE8980@parisc-linux.org>
Message-Id: <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 20 Mar 2006 13:19:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Unlike open files there doesn't seem to be any limit on the number of
> > locks being held either globally or by a single process.
> 
> RLIMIT_LOCKS

Which is not actually used anywhere.

Miklos
