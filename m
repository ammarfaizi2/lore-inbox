Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbVLKF1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbVLKF1N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 00:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbVLKF1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 00:27:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63714 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161084AbVLKF1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 00:27:12 -0500
Message-ID: <439BB8CC.4000301@volny.cz>
Date: Sun, 11 Dec 2005 06:27:40 +0100
From: Miloslav Trmac <mitr@volny.cz>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ashutosh Naik <ashutosh.naik@gmail.com>
CC: bero@arklinux.org, dtor@mail.ru, akpm@osdl.org, vojtech@suse.cz,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-laptop@vger.kernel.org
Subject: Re: [PATCH] drivers/input/misc: Added Acer TravelMate 240 support
 to the wistron button interface
References: <81083a450512102116o50d71fa0gbb53557f0e3d8748@mail.gmail.com>
In-Reply-To: <81083a450512102116o50d71fa0gbb53557f0e3d8748@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashutosh Naik wrote:
> This patch adds Acer TravelMate 240 support to the wistron button
> interface. This means that the buttons on top of the
> keyboard(including ones for Wifi and Bluetooth),  which hitherto did
> not work, work now. I have tested it on my laptop and it seems to work
> great.
Please check that the ACPI "button.ko" driver can't provide the
functionality; newer laptops apparently work better with that driver
(http://lkml.org/lkml/2005/12/2/61).

Thanks,
	Mirek
