Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbTFMAaJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 20:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbTFMAaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 20:30:09 -0400
Received: from quechua.inka.de ([193.197.184.2]:208 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265083AbTFMAaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 20:30:06 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Real multi-user linux
In-Reply-To: <20030612231942.78086.qmail@web12905.mail.yahoo.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19QcfW-0003ce-00@calista.inka.de>
Date: Fri, 13 Jun 2003 02:43:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030612231942.78086.qmail@web12905.mail.yahoo.com> you wrote:
> is it possible to use several logical terminals
> (=tupels of monitor, keyboard and mouse) directly
> connected to _one_ system?

Yes sure.

> But is there a possibility to group these to allow two
> users work simultanously on the same machine without
> having to go via serial console or network?

the main problem is the hardware. It is most often easier to have a diskless
terminal connected via network, than to have a VGA cable to two workplaces.

Linux supports multiple XServers (on multiple cards or cards with multiple
ports), can you can configure them for multiple serial ports or usb ports
for the mouse. For the keyboard you can have one ps2 and multiple usb ports
(under x). I am not sure how the console handles multiple usb keyboards.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
