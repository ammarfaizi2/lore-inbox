Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131535AbRCSSjk>; Mon, 19 Mar 2001 13:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131542AbRCSSja>; Mon, 19 Mar 2001 13:39:30 -0500
Received: from ns.palaver.net ([208.15.176.1]:40719 "EHLO farout.palaver.net")
	by vger.kernel.org with ESMTP id <S131535AbRCSSjY>;
	Mon, 19 Mar 2001 13:39:24 -0500
Message-ID: <3AB6522C.D7E66E73@palaver.net>
Date: Mon, 19 Mar 2001 13:38:36 -0500
From: Brian Capouch <brianc@palaver.net>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.3-pre4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cisco 342 Driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an "information pointer" request.  I see there has been patching
activity fairly recently for the aironet4800 drivers, but have been
unable to successfully contact the maintainer listed in the sources.

Is there anyone out in kernel-list land with this thing running on a
PCI-based 340 series card, as opposed to PCMCIA?

When I configure my kernel to include the various pieces of the driver
inside the kernel (as opposed to as modules) the configure script will
NOT let me configure the /proc interface inside the kernel too,
complaining that it must be a module "to be consistent with the other
configuration choices" I have made.  That doesn't make sense.  If I
override that in .config, I get an OOPS when I boot up and first execute
ifconfig on *any* network device.

If I build the set as modules I get errors at module load time.

Etc.  I need either configuration information or a pointer to someone to
talk to about this.

Thanks.

B.
