Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWBNFVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWBNFVY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbWBNFVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:21:22 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:32871 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030454AbWBNFVM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:21:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ESFJ1VZ4arbkDy8k94Y3JNQwpSRVdg4XMEXtLwMUasKNaSu+DoxqzsWWGiF1CyUdREaxbbVS42SSQ027IChvqQMyQZ1ffGcSajcQKHVY+mpfar1rsdXifXZe2diZrgJRYqbFexe8lp7KmJesJNNlmycWGE/74WOp2GugAtsFS2I=
Message-ID: <417f1b740602132121q3d9c19a8r6d5c3d8b042991ac@mail.gmail.com>
Date: Tue, 14 Feb 2006 10:51:11 +0530
From: Pramod P K <pra.engr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: how test keypad driver in 2.6.10
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I need to test a keypad driver in 2.6.10. For that, to write a simple
application to read the device file and write it to display, dont I
need node to be in "/dev " ?.  But I agree, in 2.6, concept has been
changed. When I do

# cat /proc/bus/input/devices

I get

I: Bus=0019 Vendor=0001 Product=0001 Version=0100
N: Name="KBD"
P: Phys=
H: Handlers=kbd
B: EV=3
B: KEY=800 1681 0 38a14001 50004ffc

Ive gone through "Using the Input Subsystem", By Brad Hards, published
in Linux Journal. link: http://www.linuxjournal.com/article/6429
How to use Handlers ??

dev fs entry is not created. But sys fs entry
/sys/devices/platform/keypad/driver/keypad/driver/keypad/..... goes
indefinitely. same is with
/sys/bus/platform/devices/keypad/driver/keypad/driver/..........

but couldnt find how to get a way to access kbd from user space.
Can any one have example ??

Please anyone, help me.
regards,
--pramod
