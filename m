Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUCPSvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUCPSvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:51:23 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:60678 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S261273AbUCPStt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:49:49 -0500
Date: Tue, 16 Mar 2004 19:46:40 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: 3-order allocation failed with cdda2wav
Message-ID: <20040316184640.GA14088@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I've recently started to use cdda2wav (I've been using cdparanoia
for years and wanted to take a look at cdda2wav), and I have a
problem: each time I use cdda2wav the kernel spills '__alloc_pages:
3-order allocation failed (gpf=0x20/0)' six times.

    I'm using cdrtools 2.0.3, with kernel 2.4.25 and ide-scsi. I have
a Plextor CD-writer that I use to do CDDA ripping, but the problem
appears with other drives too (I've tested with a Liteon DVD, too).

    Maybe a cdda2wav problem? Kernel problem?

    In addition to this problem, I have another one, this time
related with interfaces: if I use the SCSI generic interface with
cdda2wav, it runs without problems (well, except that noted above)
but uses a lot of CPU (up to 60%), so I tested with cooked_ioctl
interface, and then the CPU use drops to 4% but I got two error
messages about CDIOCSETCDDA not available, but the allocation problem
DOES NOT HAPPEN :?

    Any help? Thanks in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
