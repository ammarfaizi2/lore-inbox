Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVA2EDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVA2EDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 23:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVA2EDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 23:03:20 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:3548 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262846AbVA2ECx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 23:02:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=MiWl+Tp5xg9QvXno4It+on5rkKR3ml4eOsR0MgFcVF40Srb5Umgzd5Cb76KBVCvdgsG2H5wAfOSUSQwIKUFI40NmbIH+cEZJexvce7niqosZ0YwoLp0Eln2PO4gIqEZROq6yPXzY+lblYBK5n5+5sRpUZutwX7aGRsFouMSYVng=
Message-ID: <9e4733910501282002665eb532@mail.gmail.com>
Date: Fri, 28 Jan 2005 23:02:52 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: USB HID events and Microsoft wheel mouse
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something changed in the Linus BK kernel in the last few days so that
I get "drivers/usb/input/hid-input.c: event field not found" in dmesg
everytime I move my MS Wheel mouse. Any ideas on how to get rid of
this?

The events are EV_MISC:
type 4 code 4 value 65585
type 4 code 4 value 65584
type 4 code 4 value 589825

-- 
Jon Smirl
jonsmirl@gmail.com
