Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbUJZVXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbUJZVXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbUJZVXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:23:31 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:5067 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S261480AbUJZVXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:23:22 -0400
Message-ID: <417EDFFC.4090004@home.nl>
Date: Tue, 26 Oct 2004 23:38:36 +0000
From: Ramon de Ruiter <won@home.nl>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jgarzik@pobox.com
CC: linux-kernel@vger.kernel.org, drlion@deepwood.net
Subject: sata related hang with linux-2.6
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

About once every three times i power-on my pc, it won't load the OS.
When the kernel is at the point of initializing my harddisk, it just
hangs with error message:

IRQ 10: Nobody cared!
(the following about 20 times and with different codes and messages for 
the "...":)
[c01061da>] ...
Disabling IRQ# 10 ata1: dev 0 ATA, max UDMA/100, 4d88960 sectors.

I'm not able to capture it decently but perhaps i
could make a decent photo of it if necessary.
When this happens, i reset the system and then it boots just fine.

I have a Abit motherboard with Nforce2 chipset and Silicon Image
Sata(raid) controller (CONFIG_SCSI_SATA_SIL) I have a 20G ide disk
attached to the Sata controller via a "serillel" converter and Sata
cable. I don't think the serillel part is the problem since i found
someone else, he's on CC, with native sata who expierences the same error.

I now use the 2.6.9 kernel but the problem is also reproducable with
2.6.7, 2.6.8 and a few kernels i tried before these.

Is such a bug already known, and what can i do to help?

Ramon.

