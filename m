Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263637AbRFARue>; Fri, 1 Jun 2001 13:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263639AbRFARuX>; Fri, 1 Jun 2001 13:50:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56329 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263637AbRFARuT>; Fri, 1 Jun 2001 13:50:19 -0400
Subject: Re: [newbie] NFS broken in 2.4.4?
To: rkuhn@e18.physik.tu-muenchen.de (Roland Kuhn)
Date: Fri, 1 Jun 2001 18:45:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0106011808310.13429-100000@pc40.e18.physik.tu-muenchen.de> from "Roland Kuhn" at Jun 01, 2001 06:17:28 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155syt-0000ov-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When a process tries to lstat64 a file on nfs and the reply is not
> received it gets blocked forever. Should it be that way?

Yes. Unless you made the mount with -o soft. The box will wait until the server
comes back

