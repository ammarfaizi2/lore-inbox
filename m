Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVA0QUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVA0QUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVA0QUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:20:22 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29877 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262647AbVA0QUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:20:16 -0500
Subject: Re: i8042 access timings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <1106685456.10845.40.camel@krustophenia.net>
References: <200501250241.14695.dtor_core@ameritech.net>
	 <20050125105139.GA3494@pclin040.win.tue.nl>
	 <d120d5000501251117120a738a@mail.gmail.com>
	 <20050125194647.GB3494@pclin040.win.tue.nl>
	 <1106685456.10845.40.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106838875.14782.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 27 Jan 2005 15:14:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-25 at 20:37, Lee Revell wrote:
> Seems like a comment along the lines of "foo hardware doesn't work right
> unless we delay a bit here" is the obvious solution.  Then someone can
> easily disprove it later.

Myths are not really involved here. The IBM PC hardware specifications
are fairly well defined and the various bits of "we glued a 2Mhz part
onto the bus" stuff is all well documented. Nowdays its more complex
because most kbc's aren't standalone low end microcontrollers but are
chipset integrated cells or even software SMM emulations.

The real test is to fish out something like an old Digital Hi-note
laptop or an early 486 board with seperate kbc and try it.

Alan

