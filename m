Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUF0QKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUF0QKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 12:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUF0QKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 12:10:16 -0400
Received: from mail1.kontent.de ([81.88.34.36]:18574 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263664AbUF0QKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 12:10:11 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: drivers/block/ub.c
Date: Sun, 27 Jun 2004 18:11:07 +0200
User-Agent: KMail/1.6.2
Cc: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com, arjanv@redhat.com,
       jgarzik@redhat.com, tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406271624.18984.oliver@neukum.org> <20040627152321.GH5526@pclin040.win.tue.nl>
In-Reply-To: <20040627152321.GH5526@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406271811.07249.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 27. Juni 2004 17:23 schrieb Andries Brouwer:
> Always write simple direct obvious code. Avoid all casts.
> Uglifying code burdens maintenance. It endangers correctness.
> It is reasonable only when efficiency is really important,
> when every nanosecond counts (and the ugly code is really faster).
> That is not the case here.

No, writing the same code thousands of times makes code
unmaintainable. Finding correct and nice helper macros makes
the code good. Doing things "by foot" is the stone age way.

	Regards
		Oliver

