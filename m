Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263887AbRFTWFg>; Wed, 20 Jun 2001 18:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbRFTWF0>; Wed, 20 Jun 2001 18:05:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14348 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263887AbRFTWFK>; Wed, 20 Jun 2001 18:05:10 -0400
Subject: Re: [PATCH] remove null register_disk
To: Andries.Brouwer@cwi.nl
Date: Wed, 20 Jun 2001 23:03:21 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <UTC200106201958.VAA343451.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at Jun 20, 2001 09:58:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Cq4H-0000Bm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> showing that register_disk is void when its first argument is NULL.
> This allows one to remove some dead code.
> Can be applied to 2.4. No behaviour is changed.

Is it worth keeping these so we can build things like nice /proc files or
use them later ?
