Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVAPNNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVAPNNr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 08:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVAPNNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 08:13:47 -0500
Received: from s217-115-138-13.colo.hosteurope.de ([217.115.138.13]:52694 "EHLO
	mail.beamnet.de") by vger.kernel.org with ESMTP id S262499AbVAPNNk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:13:40 -0500
Message-ID: <41EA688A.6050305@beamnet.de>
Date: Sun, 16 Jan 2005 14:13:46 +0100
From: Thomas Viehmann <tv@beamnet.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: permissions of /proc/tty/driver
References: <41E80535.1060309@beamnet.de> <20050116120436.GA13906@lst.de>
In-Reply-To: <20050116120436.GA13906@lst.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Christoph Hellwig wrote:
> Counter-question:  What information is available in
> /proc/tty/driver/usbserial but not in sysfs?

Thanks for this hint, is there a way of finding vendor and product ids 
of all ttyUSB devices better than
looking for /sys/bus/usb/devices/*-*/*-*:*/ttyUSB* and then ckecking the 
obvious files in the grandparent directory?

Kind regards

Thomas
-- 
Thomas Viehmann, <http://thomas.viehmann.net/>
