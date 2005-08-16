Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932730AbVHPVVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbVHPVVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbVHPVVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:21:41 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:1732 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932725AbVHPVVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:21:40 -0400
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <58cb370e050816134270b445ea@mail.gmail.com>
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <200508151507.22776.bjorn.helgaas@hp.com>
	 <58cb370e050816023845b57a74@mail.gmail.com>
	 <200508161316.32602.bjorn.helgaas@hp.com>
	 <1124223946.22924.4.camel@localhost.localdomain>
	 <58cb370e050816134270b445ea@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Aug 2005 22:48:43 +0100
Message-Id: <1124228924.22924.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-16 at 22:42 +0200, Bartlomiej Zolnierkiewicz wrote:
> IMO this is much better solution as:
> * you go from working code into small steps (evolution)

If there was working code to go from maybe. The IDE core code is far too
broken for that to be the case. The drivers are different matter
although the driver API is fundamentally flawed because it handles speed
changing in a synchronous manner.

> * it shouldn't be that hard - I have many parts of the stuff
>   done (they need some polishing)

Fair enough. Be good to see the core IDE get better whichever path

