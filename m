Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVFMNiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVFMNiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 09:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVFMNiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 09:38:11 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:48600 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261551AbVFMNiK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 09:38:10 -0400
Subject: Re: A Great Idea (tm) about reimplementing NLS.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <f192987705061303383f77c10c@mail.gmail.com>
References: <f192987705061303383f77c10c@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118669746.13260.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Jun 2005 14:35:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-06-13 at 11:38, Alexey Zaytsev wrote:
> Instead of adding NLS support to filesystems who don't have it yet, I
> think there should be a global NLS layer, to convert file names from
> any to any encoding, independent of file system and transparently to
> the user.

Thats essentially what we have. The core OS is UTF-8, the fat and one or
two other legacy file systems support mapping old and/or inferior
encodings into utf-8 (and some other stuff).

Alan

