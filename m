Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293139AbSBZUgF>; Tue, 26 Feb 2002 15:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293380AbSBZUfz>; Tue, 26 Feb 2002 15:35:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2309 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293139AbSBZUfo>; Tue, 26 Feb 2002 15:35:44 -0500
Subject: Re: [PATCH] 2.4.18 Eicon ISDN driver fix.
To: petter@bluezone.no (petter wahlman)
Date: Tue, 26 Feb 2002 20:50:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, info@melware.de
In-Reply-To: <1014679267.27236.6.camel@BadEip> from "petter wahlman" at Feb 26, 2002 08:26:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16foYQ-0001zw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following code is calling a possibly blocking operation while
> holding a spinlock.

Definitely a bug - but can you prove dropping the lock there is safe ?
