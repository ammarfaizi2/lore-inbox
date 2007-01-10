Return-Path: <linux-kernel-owner+w=401wt.eu-S964919AbXAJP4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbXAJP4j (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 10:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbXAJP4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 10:56:39 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:56684 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964919AbXAJP4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 10:56:38 -0500
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2007 10:56:38 EST
Date: Wed, 10 Jan 2007 16:49:35 +0100 (MET)
From: Oliver Neukum <oneukum@suse.de>
Organization: Novell
To: Pavel Machek <pavel@ucw.cz>, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.20-rc4: null pointer deref in khubd
User-Agent: KMail/1.9.1
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
References: <20070110104937.GA32112@elf.ucw.cz>
In-Reply-To: <20070110104937.GA32112@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701101653.57929.oneukum@suse.de>
X-RZG-AUTH: kN+qSWxTQH+Xqix8Cni7tCsVYhPCm1GP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Januar 2007 11:49 schrieb Pavel Machek:
> usb 2-1: new full speed USB device using uhci_hcd and address 68
> usb 2-1: USB disconnect, address 68
> usb 2-1: unable to read config index 0 descriptor/start
> usb 2-1: chopping to 0 config(s)

Does anybody know a legitimate reasons a device should have
0 configurations? Independent of the reason of this bug, should we disallow
such devices and error out?

	Regards
		Oliver
