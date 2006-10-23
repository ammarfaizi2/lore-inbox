Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWJWOCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWJWOCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWJWOCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:02:54 -0400
Received: from lx1.pxnet.com ([195.227.45.3]:64941 "EHLO lx1.pxnet.com")
	by vger.kernel.org with ESMTP id S1751094AbWJWOCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:02:53 -0400
Date: Mon, 23 Oct 2006 16:02:49 +0200
Message-Id: <200610231402.k9NE2n9t015705@lx1.pxnet.com>
From: Tilman Schmidt <tilman@imap.cc>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] bit revese library
References: <20061018163633.GA21820@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 01:36:33 +0900, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> This patch provides two bit reverse functions and bit reverse table.

drivers/isdn/gigaset/common.c also contains a private bit reverse
table, gigaset_invtab[256].  Would you mind extending your patchset
to convert that to your functions, too?

Thanks
Tilman

