Return-Path: <linux-kernel-owner+w=401wt.eu-S964968AbWL1JRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWL1JRl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 04:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWL1JRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 04:17:41 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:45902 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964968AbWL1JRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 04:17:40 -0500
Date: Thu, 28 Dec 2006 10:13:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mike Huber <michael.huber@gmail.com>
cc: Denis Vlasenko <vda.linux@googlemail.com>,
       Michael Tokarev <mjt@tls.msk.ru>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Raid 0 Swap?
In-Reply-To: <e1a7ee0c0612272106y5e22dd21uc3f2fde567ab7532@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0612281011530.15825@yvahk01.tjqt.qr>
References: <44FB5AAD.7020307@perkel.com> <44FBFFFC.90309@tls.msk.ru> 
 <Pine.LNX.4.61.0609041242350.17115@yvahk01.tjqt.qr> 
 <200609181150.23091.vda.linux@googlemail.com>
 <e1a7ee0c0612272106y5e22dd21uc3f2fde567ab7532@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 28 2006 00:06, Mike Huber wrote:
>
> I would like to point out one key argument against raid0 swap partitions,
> which is that, should a drive failure occur, the least used programs in
> memory are most drastically affected.  Unfortunately, in the case of a
> drastic drive failure in a standalone server, one of the most likely
> programs to be affected is getty, disallowing you from manually logging in.

However, the footprint of getty is rather small, so its chance to run is higher
than an idle bigger task (dbus, resmgr, hal, perhaps cron or X)


	-`J'
-- 
