Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281077AbRLZOyh>; Wed, 26 Dec 2001 09:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281450AbRLZOy0>; Wed, 26 Dec 2001 09:54:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15370 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281077AbRLZOyR>; Wed, 26 Dec 2001 09:54:17 -0500
Subject: Re: 2.5.2-pre2 forces ramfs on
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 26 Dec 2001 15:04:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a0bj07$18l$1@penguin.transmeta.com> from "Linus Torvalds" at Dec 26, 2001 04:17:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JFbk-00028a-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Because it's small, and if it wasn't there, we'd have to have the small
> "rootfs" anyway (which basically duplicated ramfs functionality).

Can ramfs=N longer term actually come back to be "use __init for the RAM
fs functions". That would seem to address any space issues even the most 
embedded fanatic has. 

Alan
