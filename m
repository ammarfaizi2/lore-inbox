Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTEMBQz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 21:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTEMBQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 21:16:55 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:26837 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262451AbTEMBQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 21:16:54 -0400
Date: Tue, 13 May 2003 02:29:33 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: re-scanning the PCI bus after boot for configurable device...
Message-ID: <Pine.LNX.4.53.0305130225240.20908@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,
	I've got a PCI card that has an FPGA on it which I want to program
at run time, and then load a device driver for depending on what I've
loaded in to the FPGA,

The FPGA is downloaded via JTAG so that is all fine, but if I boot Linux,
download over the JTAG, how can I get Linux to see the device? can I use
the hotplugging support or do I still need to do more work? I know the
hotplug allows for PCMCIA and CompactPCI to add devices after boot, but
this is plain PCI but the device won't be there until the system is
running,

I know I can in theory put an image in the FPGA from an EEPROM which
enough to get by, but I'd rather not put an EEPROM anywhere near the board
if possible,

Thanks,
Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person

