Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130319AbRBSBxu>; Sun, 18 Feb 2001 20:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130401AbRBSBxk>; Sun, 18 Feb 2001 20:53:40 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62734 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130319AbRBSBx3>; Sun, 18 Feb 2001 20:53:29 -0500
Subject: Re: Proliant hangs with 2.4 but works with 2.2.
To: lafanga1@hotmail.com (lafanga lafanga)
Date: Mon, 19 Feb 2001 01:53:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F91i3lDraH8kvLMxLQn00012fe9@hotmail.com> from "lafanga lafanga" at Feb 18, 2001 11:08:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UfWc-00028y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The programs 'gpm', 'kudzu' and 'startx' all hang the server immediately 
> after they exit (with exit status 0). I cannot pinpoint why the kernel hangs 
> and would appreciate any help. The only thing I suspect it may be is that it 

The three of them all touch the mouse. Does 

dd if=/dev/psaux of=/dev/null count=256

also hang the box ?

