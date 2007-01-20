Return-Path: <linux-kernel-owner+w=401wt.eu-S965352AbXATS4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965352AbXATS4k (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 13:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965351AbXATS4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 13:56:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:33965 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965352AbXATS4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 13:56:39 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Sv5ASKLDnHbhGvnrIGMXzImkOimQ+9BNugwzpNYiaivwuE9U1oI5brIhb3WHmqn0PX6jhI3bKoZXBLRp28aCAGeyb+oGv+0KAHEZcvCZ6a4oz6JRNQqhpHbg1L4PFlzqP6OfR3mfsbfEzRHic5OHMAmTArIPvc9Xfyfie5oNA/8=
Message-ID: <45B265E0.5020605@gmail.com>
Date: Sat, 20 Jan 2007 21:56:32 +0300
From: Ivan Ukhov <uvsoft@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: UVSoft@gmail.com
Subject: How to use an usb interface than is claimed by HID?
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I'm writing a driver for an USB device that has one configuration with
several interfacies and one of them is a HID interface. So when I check
this interface whether it's claimed (usb_interface_claimed), I find out
that it is, and it's claimed by the HID driver. So here is the
question: how can I ask the HID driver to unclaim this very interface
for me so that I can use it? The HID driver is needed for some other
devices, so I can't just rmmod it.

Thanks in advice.

Regards,
Ivan Ukhov.
