Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVAPTNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVAPTNz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVAPTNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:13:55 -0500
Received: from main.gmane.org ([80.91.229.2]:13719 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262571AbVAPTNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:13:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: permissions of /proc/tty/driver
Date: Sun, 16 Jan 2005 22:13:45 +0300
Message-ID: <pan.2005.01.16.19.13.45.210905@altlinux.ru>
References: <41E80535.1060309@beamnet.de> <20050116120436.GA13906@lst.de> <41EA688A.6050305@beamnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213.177.124.23
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jan 2005 14:13:46 +0100, Thomas Viehmann wrote:

> Christoph Hellwig wrote:
>> Counter-question:  What information is available in
>> /proc/tty/driver/usbserial but not in sysfs?
> 
> Thanks for this hint, is there a way of finding vendor and product ids 
> of all ttyUSB devices better than
> looking for /sys/bus/usb/devices/*-*/*-*:*/ttyUSB* and then ckecking the 
> obvious files in the grandparent directory?

/sys/bus/usb-serial/devices/* looks like what you need...

