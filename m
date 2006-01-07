Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030617AbWAGWPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030617AbWAGWPS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbWAGWPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:15:17 -0500
Received: from gate.crashing.org ([63.228.1.57]:2709 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030617AbWAGWPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:15:15 -0500
Subject: Re: request for opinion on synaptics, adb and powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Peter Osterlund <petero2@telia.com>,
       Luca Bigliardi <shammash@artha.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060107184024.GA11183@corona.suse.cz>
References: <20060106231301.GG4732@kamaji.shammash.lan>
	 <1136608396.4840.206.camel@localhost.localdomain>
	 <20060107082523.GA6276@corona.ucw.cz>
	 <200601071104.53188.dtor_core@ameritech.net>
	 <20060107184024.GA11183@corona.suse.cz>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 09:15:47 +1100
Message-Id: <1136672147.30123.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I know, but this will not be possible if the Synaptics pad is connected
> over ADB, which is the case I believe we are discussing here. 
> 
> On the other hand, if it's just PS/2 over ADB, a serio driver instead of
> an input driver would make more sense.

No, it's ADB protocol down to the communication with the PMU.

Ben.


