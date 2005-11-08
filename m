Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbVKHBGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbVKHBGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVKHBGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:06:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965026AbVKHBGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:06:08 -0500
Date: Mon, 7 Nov 2005 17:06:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/6] fat: Support a truncate() for expanding size
Message-Id: <20051107170626.4d08e8d6.akpm@osdl.org>
In-Reply-To: <87r79ss658.fsf_-_@devron.myhome.or.jp>
References: <87hdaotlci.fsf@devron.myhome.or.jp>
	<87d5lctl5y.fsf@devron.myhome.or.jp>
	<878xw0tl3r.fsf_-_@devron.myhome.or.jp>
	<874q6otl0q.fsf_-_@devron.myhome.or.jp>
	<87zmogs6cs.fsf_-_@devron.myhome.or.jp>
	<87vez4s6b7.fsf_-_@devron.myhome.or.jp>
	<87r79ss658.fsf_-_@devron.myhome.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> +static int fat_cont_expand(struct inode *inode, loff_t size)

Is it not possible to extend generic_cont_expand() so that fatfs can use it?
