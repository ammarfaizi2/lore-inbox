Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131359AbRBMW23>; Tue, 13 Feb 2001 17:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131348AbRBMW2T>; Tue, 13 Feb 2001 17:28:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18444 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131312AbRBMW2L>; Tue, 13 Feb 2001 17:28:11 -0500
Subject: Re: Stale super_blocks in 2.2
To: pauld@egenera.com (Phil Auld)
Date: Tue, 13 Feb 2001 22:28:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A89B3FD.62313E6C@egenera.com> from "Phil Auld" at Feb 13, 2001 05:23:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Snw6-00036v-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> does not do anything to invalidate the buffers associated with the
> unmounted device. We then rely on disk change detection on a 
> subsequent mount to prevent us from seeing the old super_block.

2.2 yes, 2.4 no
