Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265913AbRFYUia>; Mon, 25 Jun 2001 16:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265912AbRFYUiU>; Mon, 25 Jun 2001 16:38:20 -0400
Received: from anime.net ([63.172.78.150]:1042 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S265913AbRFYUiH>;
	Mon, 25 Jun 2001 16:38:07 -0400
Date: Mon, 25 Jun 2001 13:33:53 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <joeja@mindspring.com>, <linux-kernel@vger.kernel.org>
Subject: Re: AMD thunderbird oops
In-Reply-To: <E15EQHP-0001ET-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0106251332180.31826-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2001, Alan Cox wrote:
> Random oopses normally indicate faulty board cpu or ram (and the fault may
> even just be overheating or dimms not in the sockets cleanly). I doubt its
> the board design or model that is the problem, you probably jut have a faulty
> component somewhere if its oopsing randomly even during installs and stuff

Ive found a number of problems can be traced to power supply problems, the
board providing a bit of under voltage. Manually adjusting CPU voltage a
notch or two up has fixed many a board for me.

Also manually adjusting SDRAM drive strength can help, BIOS sometimes gets
this wrong.

-Dan

