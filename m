Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262148AbREPXuC>; Wed, 16 May 2001 19:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262153AbREPXtw>; Wed, 16 May 2001 19:49:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46605 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262148AbREPXtt>; Wed, 16 May 2001 19:49:49 -0400
Subject: Re: 2.2.20pre2aa1
To: dean-list-linux-kernel@arctic.org (dean gaudet)
Date: Thu, 17 May 2001 00:46:10 +0100 (BST)
Cc: andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105161018440.25320-100000@twinlark.arctic.org> from "dean gaudet" at May 16, 2001 10:25:32 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150Aza-0004ez-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i'm guessing from your description that the missed event will be noticed
> when the next socket arrives.  i.e. if the server is pretty busy then the
> missed events are not important.  but if it's not a busy server, like a
> hit every hour, then the missed event may be noticeable to browsers (as a
> timeout waiting for server activity).

I think so. Im still not convinced the bug is anything but theoretical but its
on my list and if it makes sense then Andrea's patch will go in

