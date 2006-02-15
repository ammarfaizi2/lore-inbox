Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422990AbWBOHbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422990AbWBOHbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 02:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422992AbWBOHbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 02:31:13 -0500
Received: from quechua.inka.de ([193.197.184.2]:35527 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1422990AbWBOHbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 02:31:13 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Cc: rolandd@cisco.com
Subject: Re: [PATCH] Fix up MADV_DONTFORK/MADV_DOFORK definitions
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <adaslqlqgdz.fsf_-_@cisco.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1F9H83-0001iU-00@calista.inka.de>
Date: Wed, 15 Feb 2006 08:31:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rdreier@cisco.com> wrote:
> Change MADV_DONTFORK and MADV_DOFORK to be 9 and 10 respectively.

I wonder if we can convert the alpha-asm defines to hex and to move the
flags which are common to all architectures to a arch-independend include
file?

Gruss
Bernd
