Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265680AbUATSiY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUATSgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:36:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:25985 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265682AbUATSg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:36:27 -0500
Date: Tue, 20 Jan 2004 10:36:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm5
Message-Id: <20040120103649.6b4ae959.akpm@osdl.org>
In-Reply-To: <20040120183020.GD23765@srv-lnx2600.matchmail.com>
References: <20040120000535.7fb8e683.akpm@osdl.org>
	<20040120183020.GD23765@srv-lnx2600.matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> What do these patches do?

Trivial stuff.

> > -ext2_new_inode-cleanup.patch

Use a local variable rather than reevaluating EXT2_SB() all over the place.

> > -ext2-s_next_generation-fix.patch
> > -ext3-s_next_generation-fix.patch

Initialisation and locking fixes for EXTx_SB()->s_next_generation.

> > -ext3-journal-mode-fix.patch

Correctly handle ext3's `chattr +j'


