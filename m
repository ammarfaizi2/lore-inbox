Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277954AbRJOBhS>; Sun, 14 Oct 2001 21:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277955AbRJOBhH>; Sun, 14 Oct 2001 21:37:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15120 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277954AbRJOBhA>; Sun, 14 Oct 2001 21:37:00 -0400
Subject: Re: NFS file locking?
To: lm@bitmover.com (Larry McVoy)
Date: Mon, 15 Oct 2001 02:43:21 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110141811.f9EIB4823631@work.bitmover.com> from "Larry McVoy" at Oct 14, 2001 11:11:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15swmn-0000cl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a) is it the belief of folks here that this should work?

NFSv2 doesnt have the needed semantics

> b) if performance isn't a big issue, is there any portable way to do
>    locking over NFS with just files?

The classic way is to use link(). 
