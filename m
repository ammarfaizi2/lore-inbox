Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264333AbTLYRpw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 12:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbTLYRpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 12:45:52 -0500
Received: from quechua.inka.de ([193.197.184.2]:38027 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264333AbTLYRpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 12:45:51 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Date: Thu, 25 Dec 2003 18:48:51 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing	moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.12.25.17.47.43.603779@dungeon.inka.de>
References: <20031223002126.GA4805@kroah.com>	<20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com>	<20031223131523.B6864@infradead.org> <1072193516.3472.3.camel@fur>	<20031223163904.A8589@infradead.org>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003 16:47:44 +0000, Christoph Hellwig wrote:
> I disagree. For fully static devices like the mem devices the udev
> indirection is completely superflous.

If sysfs does not contain data on mem devices, we will need makedev.

devfs did replace makedev. until udev can create all devices,
it would need to re-introduce makedev.

Andreas

