Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVBSN0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVBSN0N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 08:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVBSN0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 08:26:13 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:43166 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261710AbVBSN0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 08:26:10 -0500
Date: Sat, 19 Feb 2005 14:26:07 +0100
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FAUmachine: Looking for a good documented DMA bus master capable PCI IDE Controller card
Message-ID: <20050219132606.GH16858@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20050219102410.GD16858@cip.informatik.uni-erlangen.de> <58cb370e05021903481de251df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e05021903481de251df@mail.gmail.com>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bartlomiej,

> In IDE you have 2 devices per port and usually 2 ports per PCI device.
> There are some controller cards with 4 ports but they don't have public
> available documentation etc. I really wonder what are you trying to
> achieve and why just can't you use more than 1 "virtual" PIIX crontoller.

we implemented the PIIX controller as part of an Intel Southbridge
82371AB[1] Chip so I didn't thought that it was also available as
seperate PCI Device. Do you have any pointers to products or better
sepcification of this products?

If this is the case that would be the best solution for our problem.

[1] Intel(R) 82371AB PCI-TO-ISA/IDE Xcelerator (PIIX4) Datasheet

	http://www.intel.com/design/intarch/datashts/290562.htm
	ftp://download.intel.com/design/intarch/datashts/29056201.pdf

Greetings,
	Thomas
