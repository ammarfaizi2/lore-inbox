Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264173AbRF0LXt>; Wed, 27 Jun 2001 07:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264279AbRF0LXj>; Wed, 27 Jun 2001 07:23:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50704 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264173AbRF0LXX>; Wed, 27 Jun 2001 07:23:23 -0400
Subject: Re: driver/sound/soundcard.c lock_kernel()/unlock_kernel()
To: fdavis112@juno.com (Frank Davis)
Date: Wed, 27 Jun 2001 12:23:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010627.003255.-205571.0.fdavis112@juno.com> from "Frank Davis" at Jun 27, 2001 12:32:53 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FDPc-00052E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/sound/soundcard.c has a few lock_kernel()/unlock_kernel() calls,
> esp. in the read() and write() functions. Could these calls be easily

This is intentional. FIxing up the old OSS drivers is not worth the pain
