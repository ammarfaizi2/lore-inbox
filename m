Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbTHWV1H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 17:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbTHWV1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 17:27:07 -0400
Received: from 217-124-18-32.dialup.nuria.telefonica-data.net ([217.124.18.32]:44164
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S263021AbTHWV1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 17:27:04 -0400
Date: Sat, 23 Aug 2003 23:27:03 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: evms or lvm?
Message-ID: <20030823212703.GA25094@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3F47347F.7070103@mscc.huji.ac.il> <20030823101831.GA2857@localhost> <20030823094737.C995@animx.eu.org> <20030823141606.GD9232@wiggy.net> <3F478734.6040804@mscc.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F478734.6040804@mscc.huji.ac.il>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 23 August 2003, at 18:24:36 +0300,
Voicu Liviu wrote:

> Ok, what this means? Just to be sure I've understand...
> Thanks
> 
In 2.6.x there is just support for Device Mapper. From "Multi-device
support (RAID and LVM)" you can see:
  x x        <M>   Device mapper support
  x x        [*]     ioctl interface version 4

Both LVM2 and EVMS (from version 2.0.0) use Device Mapper. For LVM2 you
just need to get updated userspace tools from your vendor or directly
from www.sistina.com. For EVMS to work, see:
http://evms.sourceforge.net/install-2.0.html

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test4)
