Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVBVCh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVBVCh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 21:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVBVCh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 21:37:57 -0500
Received: from mxsf19.cluster1.charter.net ([209.225.28.219]:11708 "EHLO
	mxsf19.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262193AbVBVChx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 21:37:53 -0500
X-Ironport-AV: i="3.90,105,1107752400"; 
   d="scan'208"; a="615167593:sNHT25814448"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16922.39677.25633.782857@smtp.charter.net>
Date: Mon, 21 Feb 2005 21:37:49 -0500
From: "John Stoffel" <john@stoffel.org>
To: "John Stoffel" <john@stoffel.org>
Cc: me <cellsan@interia.pl>, linux-kernel@vger.kernel.org
Subject: Re: USB Storage problem (usb hangs)
In-Reply-To: <16922.30184.268574.616226@smtp.charter.net>
References: <20050220173401.48EF9E5B93@poczta.interia.pl>
	<16922.30184.268574.616226@smtp.charter.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John Stoffel <john@stoffel.org> writes:

me> Kernel: 2.6.9, 2.6.10 (i cant remember from which one is attached log).
me> Distribution: Gentoo.

John> Try upgrading to 2.6.11-rc2-mm2 or newer, I've found that usb-storage
John> works a bit better here, though I haven't confirmed this without debug
John> enabled in the usb-storage driver yet.

John> Maybe later tonight if I get a chance to reboot.

Just another note, 2.6.11-rc2-mm2 without USB-STORAGE debugging turned
on passes an 'iozone -a' test on my 40gb WD firewire/USB enclosure
under USB 2.0 interface.  

Now to swap in the problematic 120gb WD drive and see if that works
under USB as well as firewire too.  

John
