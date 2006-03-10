Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932696AbWCJIoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbWCJIoJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWCJIoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:44:08 -0500
Received: from main.gmane.org ([80.91.229.2]:1761 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752088AbWCJIoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:44:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Problems ejecting 4th-generation iPod with 2.6.15
Date: Fri, 10 Mar 2006 00:43:19 -0800
Message-ID: <dure7s$1ic$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: lal-99-128.reshall.berkeley.edu
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I plug my iPod in via USB, and later eject it, I more often than
not get this:

usb 5-5: reset high speed USB device using ehci_hcd and address 20
usb 5-5: reset high speed USB device using ehci_hcd and address 20
usb 5-5: reset high speed USB device using ehci_hcd and address 20
usb 5-5: reset high speed USB device using ehci_hcd and address 20
usb 5-5: reset high speed USB device using ehci_hcd and address 20
sd 14:0:0:0: scsi: Device offlined - not ready after error recovery
usb 5-5: USB disconnect, address 20

What's going on here?

A list of other problems that I've seen can be found on Carsten Otto's
site about his own iPod experiences, http://home.c-otto.de/ipod/...

On that page a link to a SuSE ML is linked to, blaming the choice of IO
scheduler, and recommends that people use cfq. I think this is bullshit,
but I am running anticipatory. Should I try cfq?

Thanks,

-- 
Joshua Kwan

