Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVDEUrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVDEUrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVDEUrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:47:14 -0400
Received: from soundwarez.org ([217.160.171.123]:45541 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262012AbVDEUpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:45:33 -0400
Subject: Re: [patch 0/5] Hotplug firmware loader for Keyspan usb-serial
	driver
From: Kay Sievers <kay.sievers@vrfy.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Greg KH <greg@kroah.com>, Sam Ravnborg <sam@ravnborg.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050405193859.506836000@delft.aura.cs.cmu.edu>
References: <20050405193859.506836000@delft.aura.cs.cmu.edu>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 22:45:30 +0200
Message-Id: <1112733931.3267.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 15:38 -0400, Jan Harkes wrote:
> Here is another stab at making the keyspan firmware easily loadable with
> hotplug. Differences from the previous version,
> 
> - keep the IHEX parser into a separate module.
> - added a fw-y and fw-m install targets to kbuild which will install a
>   driver's firmware files in /lib/modules/`uname -r`/firmware.
> 
> 01 - Add lib/ihex_parser.ko.

Oh, I just see now that it's a EZ-USB device. Did you try adapting the
driver to use fxload(8)? to load the firmware. I have a USB-Modem that
works perfect with loading ez-firmware that way.

Kay

