Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbUJZDBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbUJZDBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUJZDBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 23:01:00 -0400
Received: from grunt9.ihug.co.nz ([203.109.254.51]:29356 "EHLO
	grunt9.ihug.co.nz") by vger.kernel.org with ESMTP id S262139AbUJZC6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:58:47 -0400
Date: Tue, 26 Oct 2004 16:01:17 +1300 (NZDT)
From: jmduthie@ihug.co.nz
X-X-Sender: spudgun@hades.internal.beyondhelp.co.nz
To: linux-kernel@vger.kernel.org
Subject: usb-storage, hotplug, zip drive disappears after time
Message-ID: <Pine.LNX.4.58.0410261457190.29752@hades.internal.beyondhelp.co.nz>
X-I-Opt-Out-NOW: E-Mail Addresses in this message may not be used to Deliver Unsolicited Commercial E-mail - This E-Mail message is NOT a request to subscribe to any E-mail advertising service or list
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a few headless fileservers around the place with a usb zip 750
attached ans a cron job taring files to the zip then ejecting it.

it all worked perfectly until I upgraded to 2.6.x ( right upto 2.6.8.1 )

it seems that if the server is booted with the zip attached it doesn't
detect at all , unpluging and reattaching the zip drive makes the machine
detect the zip , where I can ssh in and then run my tar job manually , but
then the server just forgets the zip drive is there. it seems to power
save and disconnect and nothing I can do, from the linux side of the usb
cable, can make it reconnect, is anyone haivng sinilar problems ?



-- 
John Duthie
E-Mail:   <jmduthie@ihug.co.nz>
