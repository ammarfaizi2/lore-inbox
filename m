Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVAaXi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVAaXi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVAaXiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:38:55 -0500
Received: from gizmo07bw.bigpond.com ([144.140.70.42]:53130 "HELO
	gizmo07bw.bigpond.com") by vger.kernel.org with SMTP
	id S261440AbVAaXiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:38:03 -0500
Message-ID: <41FEC141.2060101@bigpond.net.au>
Date: Tue, 01 Feb 2005 10:37:37 +1100
From: Cal <hihone@bigpond.net.au>
Reply-To: hihone@bigpond.net.au
User-Agent: Mozilla Thunderbird 0.6+ (X11/20050122)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Subject: 2.6.11-rc2-mm2 (& bk9) - rowdy little warn in drivers/usb/input/hid-input.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=0.93.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.11-rc2-mm2 & 2.6.11-rc2-bk9 and usb mouse, the warn("event 
field not found") in drivers/usb/input/hid-input.c is hyperactive 
whenever the mouse moves.

hihone kernel: drivers/usb/input/hid-input.c: event field not found
hihone last message repeated 619 times
hihone last message repeated 919 times
hihone last message repeated 1325 times
hihone last message repeated 1045 times

On the deviant case, both type and code appear to have the value 4 (if 
that helps).  The mouse reports as
hihone kernel: input: USB HID v1.00 Mouse [Microsoft Microsoft 
IntelliMouse<AE> Optical] on usb-0000:00:07.2-2

cheers, Cal
(not subscribed, pls cc if needed)



