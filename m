Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbULTPpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbULTPpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbULTPpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:45:46 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26349 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261546AbULTPpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:45:10 -0500
Subject: Re: [bugreport] Problem when trying to mount CD/DVD (2.6.10-rc{1
	to 3-bk12}); most likely it's ide-scsi
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Christian Leber <christian@leber.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
In-Reply-To: <Pine.LNX.4.61.0412182106350.21592@yvahk01.tjqt.qr>
References: <20041218184021.GA6795@core.home>
	 <Pine.LNX.4.61.0412182106350.21592@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103553667.29968.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Dec 2004 14:41:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-12-18 at 20:07, Jan Engelhardt wrote:
> >    3-bk12}); most likely it's ide-scsi
> 
> Yes, it's very likely ide-scsi. I've heard reports of that it is totally 
> unmaintained and thus broken now that CD writing can be done over pure IDE.

Nothing in the trace points to ide-scsi and as of 2.6.9 I still
recommend people always use ide-scsi because ide-cd mishandled various
end of media conditions (fixed in 2.6.9-ac now I think)
