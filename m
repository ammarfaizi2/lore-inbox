Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268486AbRG3LGn>; Mon, 30 Jul 2001 07:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268491AbRG3LGX>; Mon, 30 Jul 2001 07:06:23 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:19216 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268486AbRG3LGV>;
	Mon, 30 Jul 2001 07:06:21 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: thierry@cri74.org
cc: Debian boot mailing list <debian-boot@lists.debian.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PCI] building PCI IDs/drivers DB from Linux kernel sources 
In-Reply-To: Your message of "Mon, 30 Jul 2001 11:33:19 +0200."
             <20010730113319.A24939@pc04.cri.cur-archamps.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Jul 2001 21:06:21 +1000
Message-ID: <22966.996491181@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001 11:33:19 +0200, 
Thierry Laronde <thierry@cri74.org> wrote:
>In order to allow a kind of light detection of hardware to be use during
>installation, I wanted to build a database (for PCI: I start with the
>easiest...) with the following format:
>
>CLASS_ID	VENDOR_ID	DEVICE_ID	driver_name

depmod already builds /lib/modules/`uname -r`/modules.pcimap containing
all the data required for PCI identification.  Before you reinvent too
many wheels, see the hotplug project,
http://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel

