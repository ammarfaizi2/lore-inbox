Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbULTPxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbULTPxF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbULTPwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:52:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28141 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261540AbULTPwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:52:33 -0500
Subject: Re: Linux 2.6.9-ac16
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412181606050.21338@yvahk01.tjqt.qr>
References: <41C2FF09.5020005@tebibyte.org>
	 <1103222616.21920.12.camel@localhost.localdomain>
	 <1103349675.27708.39.camel@tglx.tec.linutronix.de>
	 <41C448BB.1020902@tmr.com>
	 <Pine.LNX.4.61.0412181606050.21338@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103554123.30268.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Dec 2004 14:48:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-12-18 at 15:06, Jan Engelhardt wrote:
> >> Andrea's fix and the selection changes should go into 2.6.10, but I
> >> suspect that the VM gurus havent still reached a point, where they
> >> agree. I also have the feeling that the problem is partially ignored.
> >> Obviously has everybody plenty of memory in his boxes. </rant off>
> 
> Well you can always take out your VMware and cut it down to <few RAM> MB by 
> hand, just to get an experience how "low-end" users feel.

Or boot with mem=. I actually do test runs with -ac on a 128Mb box with
about 16Mb of that stolen as video ram. 2.6.9 isn't behaving perfectly
but seems reasonably ok for most loads except brokenoffice

