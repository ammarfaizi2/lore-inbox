Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262705AbREOJdC>; Tue, 15 May 2001 05:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262707AbREOJcw>; Tue, 15 May 2001 05:32:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39182 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262705AbREOJcm>; Tue, 15 May 2001 05:32:42 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 15 May 2001 10:28:52 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <Pine.LNX.4.21.0105150204020.1078-100000@penguin.transmeta.com> from "Linus Torvalds" at May 15, 2001 02:08:45 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zb8O-0002G8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> do with any specific drivers (which is why I'd be perfecly ok with still
> adding a "disk" major number, but which is why I do NOT want to have Peter
> give out "the random number of today" to various stupid device drivers).

For block devices that seems to work well. char devices are harder and I'd
rather issue the occasional new major than have people registering automatic
cabbage slicers as a tty or a disk because they cant get a device id.

Alan

