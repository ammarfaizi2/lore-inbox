Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWEDQ7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWEDQ7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 12:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWEDQ7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 12:59:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21191 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030245AbWEDQ7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 12:59:44 -0400
Subject: Re: cdrom: a dirty CD can freeze your system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060504165055.GA22880@animx.eu.org>
References: <200605041232.k44CWnFn004411@wildsau.enemy.org>
	 <1146750532.20677.38.camel@localhost.localdomain>
	 <20060504165055.GA22880@animx.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 04 May 2006 18:10:58 +0100
Message-Id: <1146762658.22308.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-04 at 12:50 -0400, Wakko Warner wrote:
> another example would be that I insert a disc, say with 159000 sectors and
> I'm able to read from it just fine.  I make the above mistake but I insert a
> disc with 200,000 sectors.  The disc will be reported with 159000 instead of
> the correct 200,000 sectors and some files will not be readable.  Again,
> rmmod and modprobe sr_mod fixes the problem.


That one I have seen with some broken media monitoring software that
never closes the file handle. What occurs then is that we don't for some
reason alway see a media change.

Is this SATA or SCSI proper ?

