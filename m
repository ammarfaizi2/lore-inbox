Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278841AbRJVOoJ>; Mon, 22 Oct 2001 10:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278840AbRJVOn7>; Mon, 22 Oct 2001 10:43:59 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40458 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278841AbRJVOnu>; Mon, 22 Oct 2001 10:43:50 -0400
Subject: Re: BUG: "ulong" in <linux/videodev.h>
To: leitner@fefe.de (Felix von Leitner)
Date: Mon, 22 Oct 2001 15:50:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011022163755.A409@fefe.de> from "Felix von Leitner" at Oct 22, 2001 04:37:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vgOw-0002B2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In that header file, "ulong" is used.  It should be __u32 instead.

I dont think that would be a good idea. ulong and u32 are different sizes
on the Alpha
