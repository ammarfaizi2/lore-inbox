Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272167AbTHDTef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 15:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272157AbTHDTef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 15:34:35 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:31933 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S272135AbTHDTec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 15:34:32 -0400
Date: Mon, 04 Aug 2003 13:36:13 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Paul Blazejowski <paulb@blazebox.homeip.net>,
       Patrick Mansfield <patmans@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-ID: <1352160000.1060025773@aslan.btc.adaptec.com>
In-Reply-To: <1060021614.889.6.camel@blaze.homeip.net>
References: <20030801182207.GA3759@blazebox.homeip.net>	 <20030801144455.450d8e52.akpm@osdl.org>	 <20030803015510.GB4696@blazebox.homeip.net>	 <20030802190737.3c41d4d8.akpm@osdl.org>	 <20030803214755.GA1010@blazebox.homeip.net>	 <20030803145211.29eb5e7c.akpm@osdl.org>	 <20030803222313.GA1090@blazebox.homeip.net>	 <20030803223115.GA1132@blazebox.homeip.net>	 <20030804093035.A24860@beaverton.ibm.com> <1060021614.889.6.camel@blaze.homeip.net>
X-Mailer: Mulberry/3.1.0b5 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Patrick,
> 
> I enabled CONFIG_SCSI_LOGGING=y in kernel then i used
> scsi_mod.scsi_logging_level=0x140 and scsi_mod.max_scsi_luns=1 when
> booting the kernel from lilo.I can see some debug information scroll on
> the screen and i did see ID0 LUN0 get probed even the correct transfer
> rate for the SCSI disk is set.I forgot but isn't there a key sequence
> when pressed it will stop the screen output like pause/break key?

You might be able to get useful information without using a serial
console if you turn off your CDROM drives so they don't add extra output,
but your best bet is to use a serial console.

--
Justin

