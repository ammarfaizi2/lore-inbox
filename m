Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbUE1Mtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUE1Mtt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUE1Mtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:49:49 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:57592 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262850AbUE1MtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 08:49:07 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Auzanneau Gregory <mls@reolight.net>, "Zhu, Yi" <yi.zhu@intel.com>
Subject: Re: idebus setup problem (2.6.7-rc1)
Date: Fri, 28 May 2004 14:50:22 +0200
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0405281244220.22881-100000@mazda.sh.intel.com> <40B7022F.1020905@reolight.net>
In-Reply-To: <40B7022F.1020905@reolight.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200405281450.22879.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 of May 2004 11:11, Auzanneau Gregory wrote:
> Zhu, Yi a écrit :
> > My bad. I missed ide_setup(), please try below patch.

Thanks.

> Patch works fine for me:
> Kernel command line: BOOT_IMAGE=LinuxNEW ro root=304 idebus=66
> ide_setup: idebus=66
> ide: Assuming 66MHz system bus speed for PIO modes

OK, now please explain why do you use 'idebus=66'. :-)

> Thanks a lot,

