Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292539AbSCKUAs>; Mon, 11 Mar 2002 15:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292520AbSCKUA2>; Mon, 11 Mar 2002 15:00:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60429 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292294AbSCKUAW>; Mon, 11 Mar 2002 15:00:22 -0500
Subject: Re: ide timer trbl ...
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Mon, 11 Mar 2002 20:15:52 +0000 (GMT)
Cc: davidel@xmailserver.org (Davide Libenzi),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        axboe@suse.de (Jens Axboe)
In-Reply-To: <3C8D0B56.7090505@evision-ventures.com> from "Martin Dalecki" at Mar 11, 2002 08:53:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kWD2-0001bG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would you mind as well to just apply ide-clean-18 and ide-clean-19
> on top of each other and recheck?

We see that one on 2.4 if you enable some of the work in progress options.
It seems that the timeout path is forgetting to clear the old handler. I've
not pinned it down since its deep in the WIP stuff.
