Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbRE0QMJ>; Sun, 27 May 2001 12:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbRE0QL7>; Sun, 27 May 2001 12:11:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49931 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262796AbRE0QLs>; Sun, 27 May 2001 12:11:48 -0400
Subject: Re: [PATCH] scsi_ioctl.c
To: suntzu@stanford.edu (John Martin)
Date: Sun, 27 May 2001 13:38:59 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <Pine.GSO.4.31.0105262008040.19602-100000@elaine18.Stanford.EDU> from "John Martin" at May 26, 2001 08:19:11 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153zox-0001oH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this seems to be a straight forward case of memory not being freed on an
> error path.  so i just added in one line to each of the if statements that
> could fail.

Umm.. Thats only a partial fix. Thats good because I fixed the other half
and missed that bit - there is a buffer tht may need freeing too.
