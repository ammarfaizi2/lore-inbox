Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966256AbWKTRcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966256AbWKTRcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966257AbWKTRcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:32:17 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:53177 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S966256AbWKTRcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:32:16 -0500
Message-ID: <4561E68E.7040007@gmail.com>
Date: Mon, 20 Nov 2006 18:31:58 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kobject_add failed with -EEXIST
References: <4561E290.7060100@gmail.com> <20061120172733.GA26713@suse.de>
In-Reply-To: <20061120172733.GA26713@suse.de>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Nov 20, 2006 at 06:14:56PM +0100, Jiri Slaby wrote:
>> DEV: Unregistering device. ID = 'cls_device'
>> PM: Removing info for No Bus:cls_device
>> device_create_release called for cls_device
>> device class 'cls_class': unregistering
>> class 'cls_class': release.
>> class_create_release called for cls_class
>> cls_exit
> 
> What does sysfs look like at this point in time?  Does
> /sys/class/cls_class exist?

No, there is no such dir (it disappears).

> Also, which kernel version are you using here?

2.6.19-rc6, 2.6.19-rc5-mm2

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
