Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314355AbSDRN7l>; Thu, 18 Apr 2002 09:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314356AbSDRN7k>; Thu, 18 Apr 2002 09:59:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51983 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314355AbSDRN7j>; Thu, 18 Apr 2002 09:59:39 -0400
Subject: Re: [PATCH] IDE TCQ #4
To: axboe@suse.de (Jens Axboe)
Date: Thu, 18 Apr 2002 15:17:34 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020418131248.GI2492@suse.de> from "Jens Axboe" at Apr 18, 2002 03:12:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16yCj8-0004kW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It sure is... sr doesn't do it and lots of others don't as well, so I
> suppose we could rip it out. We already require reblocking with loop in
> those cases anyway.

For the file system ones. It would be nice to be able to handle non power
of two block sizes as well through the block interface (even if it means we
hand back a 4K buffer that the caller is required to know is partly full).
That would remove a lot of special case magic for audio/video

