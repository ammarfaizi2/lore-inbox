Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272140AbTHDS54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272153AbTHDS54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:57:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:10625 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S272140AbTHDS5x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:57:53 -0400
Date: Mon, 4 Aug 2003 11:57:25 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Paul Blazejowski <paulb@blazebox.homeip.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-ID: <20030804115725.A26812@beaverton.ibm.com>
References: <20030801182207.GA3759@blazebox.homeip.net> <20030801144455.450d8e52.akpm@osdl.org> <20030803015510.GB4696@blazebox.homeip.net> <20030802190737.3c41d4d8.akpm@osdl.org> <20030803214755.GA1010@blazebox.homeip.net> <20030803145211.29eb5e7c.akpm@osdl.org> <20030803222313.GA1090@blazebox.homeip.net> <20030803223115.GA1132@blazebox.homeip.net> <20030804093035.A24860@beaverton.ibm.com> <1060021614.889.6.camel@blaze.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1060021614.889.6.camel@blaze.homeip.net>; from paulb@blazebox.homeip.net on Mon, Aug 04, 2003 at 02:26:54PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 02:26:54PM -0400, Paul Blazejowski wrote:
> 
> Patrick,
> 
> I enabled CONFIG_SCSI_LOGGING=y in kernel then i used
> scsi_mod.scsi_logging_level=0x140 and scsi_mod.max_scsi_luns=1 when
> booting the kernel from lilo.I can see some debug information scroll on
> the screen and i did see ID0 LUN0 get probed even the correct transfer
> rate for the SCSI disk is set.I forgot but isn't there a key sequence
> when pressed it will stop the screen output like pause/break key?
> 
> I have few screen snaps which can be viewed at 
> http://www.blazebox.homeip.net:81/diffie/images/linux-2.6.0-test2/aic7xxx/

Yep, the shot that might have useful information is blurred.

I assume you are unable to use a serial console.

I can usually "Shift + page-up" as long as there is not too much data, and
depending on your console, AFAIR I can't pause my console output.

Also, does the adapter bios show the drive at boot time?

Hopefully Justin will add more useful suggestions for debugging.

-- Patrick Mansfield
