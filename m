Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273051AbTHKSnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273002AbTHKSmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:42:05 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:27783 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S273015AbTHKSk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:40:27 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 11 Aug 2003 20:40:16 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Flameeyes <daps_mls@libero.it>, Pavel Machek <pavel@suse.cz>,
       Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811184016.GC17777@bytesex.org>
References: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz> <1060334463.5037.13.camel@defiant.flameeyes> <20030808231733.GF389@elf.ucw.cz> <8rZ2nqa1z9B@hit-columbus.hit.handshake.de> <20030811124744.GB1733@elf.ucw.cz> <1060607466.5035.8.camel@defiant.flameeyes> <20030811144242.GE4562@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811144242.GE4562@www.13thfloor.at>
X-GPG-Fingerprint: 79C4 EE94 CC44 6DD4 58C6  3088 DBB7 EC73 8750 D2C4  [1024D/8750D2C4]
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   c) hardcode the basic decoding and use a mapping table
>      which can be configure from userspace ...
>      (like dvbs haupauge or xmodmap)

Should be possible using the existing interfaces for keyboard maps,
/dev/input/event<x> even has ioctls for that (EVIOC{GS}KEYCODE).
The dvb folks already do that as far I know.

  Gerd

-- 
sigfault
