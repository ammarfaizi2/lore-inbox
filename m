Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVCTNOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVCTNOW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 08:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVCTNOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 08:14:22 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:56272 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S261203AbVCTNOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 08:14:20 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [PATCH] don't do pointless NULL checks and casts before kfree() in security/
To: Ralph Corderoy <ralph@inputplus.co.uk>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Sun, 20 Mar 2005 14:18:43 +0100
References: <fa.p25ihnj.4026at@ifi.uio.no> <fa.iqmuavi.o6kfai@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DD0KL-0000jp-KL@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralph Corderoy <ralph@inputplus.co.uk> wrote:
> Hi Jesper,

>> kfree() handles NULL pointers, so checking a pointer for NULL before
>> calling kfree() on it is pointless.
> 
> Not necessarily.  It helps tell the reader that the pointer may be NULL
> at that point.  This has come up before.

If you want to comment code, use comments.
