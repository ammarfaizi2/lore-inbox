Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVA2CGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVA2CGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 21:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVA2CGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 21:06:49 -0500
Received: from rrcs-24-199-11-214.west.biz.rr.com ([24.199.11.214]:54925 "EHLO
	mail.cyte.com") by vger.kernel.org with ESMTP id S261417AbVA2CGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 21:06:47 -0500
Message-ID: <41FAEF8F.9010809@cyte.com>
Date: Fri, 28 Jan 2005 18:06:07 -0800
From: Jeff Wiegley <jeffw@cyte.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.10 USB devices generate descriptor read error?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anybody else having a similar problem as the
following...

My USB keydrives use to work fine in 2.6.9.
Since I upgraded to 2.6.10 now they just
generate a device descriptor read error.

Specifically:

/var/log/kern.log.0:Jan 26 18:18:18 mail kernel: usb 4-2.1:
device descriptor read/64, error -32

Also I noticed that a new Sigmatel based USB IRDA
device also produces similar messages...

/var/log/kern.log:Jan 27 12:31:19 mail kernel: usb 2-2: device
descriptor read/64, error -71

Is this a known problem or is it just me?

I noticed that the precompiled debian 2.6.10 kernel
works with at least the usb flash drive ok.  But my
compiled version produces the above.

But I don't think I changed any relevant kernel config
items from 2.6.9 to 2.6.10 and I've compiled lots of
USB enabled kernels before so I'd like to think I'm
not an idiot but maybe I missed a new option or
something.

Please help,

- Jeff

