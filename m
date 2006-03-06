Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWCFWHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWCFWHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWCFWHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:07:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932383AbWCFWHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:07:44 -0500
Date: Mon, 6 Mar 2006 14:05:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, markhe@nextd.demon.co.uk,
       andrea@suse.de, michaelc@cs.wisc.edu, James.Bottomley@steeleye.com,
       axboe@suse.de
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Message-Id: <20060306140541.16a41cd2.akpm@osdl.org>
In-Reply-To: <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
References: <200603060117.16484.jesper.juhl@gmail.com>
	<Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
	<Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
	<200603062136.17098.jesper.juhl@gmail.com>
	<9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>
	<9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>
	<Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
	<9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> Where do we go from here ?
>

If you can test just

	2.6.16-rc5 + linus.patch + git-scsi-misc.patch

then we'd have a clearer idea.

