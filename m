Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVBUX7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVBUX7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 18:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVBUX7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 18:59:41 -0500
Received: from mxsf13.cluster1.charter.net ([209.225.28.213]:57313 "EHLO
	mxsf13.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262180AbVBUX7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 18:59:40 -0500
X-Ironport-AV: i="3.90,104,1107752400"; 
   d="scan'208"; a="789621781:sNHT125156648"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16922.30184.268574.616226@smtp.charter.net>
Date: Mon, 21 Feb 2005 18:59:36 -0500
From: "John Stoffel" <john@stoffel.org>
To: me <cellsan@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Storage problem (usb hangs)
In-Reply-To: <20050220173401.48EF9E5B93@poczta.interia.pl>
References: <20050220173401.48EF9E5B93@poczta.interia.pl>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


me> The device is: USB2.0 to IDE 3.5" hard disk enclosure.
me> Producer: Seven.

me> Part of /var/log/messages with USB debug enabled in kernel is
me> attached to this email.

me> Kernel: 2.6.9, 2.6.10 (i cant remember from which one is attached log).
me> Distribution: Gentoo.

Try upgrading to 2.6.11-rc2-mm2 or newer, I've found that usb-storage
works a bit better here, though I haven't confirmed this without debug
enabled in the usb-storage driver yet.

Maybe later tonight if I get a chance to reboot.

John
