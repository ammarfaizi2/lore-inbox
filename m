Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbRBYURt>; Sun, 25 Feb 2001 15:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRBYURj>; Sun, 25 Feb 2001 15:17:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18184 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129691AbRBYURZ>; Sun, 25 Feb 2001 15:17:25 -0500
Subject: Re: fat problem in 2.4.2
To: jstrand1@rochester.rr.com (James D Strandboge)
Date: Sun, 25 Feb 2001 20:20:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A996644.A5856F14@rochester.rr.com> from "James D Strandboge" at Feb 25, 2001 03:08:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14X7eW-00049F-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The bug with truncate in the fat filesystem that was present in 2.4.0,
> and fixed with the 2.4.0-ac12 (or earlier) patch is still in the main

It isnt a bug. The fix in 2.4-ac I've dropped. A program that assumes
ftruncating a file large will work is broken.

Alan

