Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757648AbWK1MUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757648AbWK1MUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 07:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758343AbWK1MUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 07:20:17 -0500
Received: from main.gmane.org ([80.91.229.2]:28560 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1757648AbWK1MUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 07:20:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Jellinghaus <aj@ciphirelabs.com>
Subject: Re: O2micro smartcard reader driver.
Date: Tue, 28 Nov 2006 13:19:26 +0100
Message-ID: <456C294E.4060006@ciphirelabs.com>
References: <20061127182817.d52dfdf1.l.bigonville@edpnet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ciphirelabs.net
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
In-Reply-To: <20061127182817.d52dfdf1.l.bigonville@edpnet.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maybe post once more, and make clear whether you are looking for:
  - smart card reader support. (smart card as in "digital signature
    card".) o2micro creates such readers, they are usualy usb devices,
    conform to the ccid standard and work fine (e.g. pcsc-lite plus
    ccid driver or openct).
  - smart media card / multi media card reader support (those small
    memory cards used by mobile phones, cameras and so on). o2micro
    creates those too, they are also build in by some vendors, but
    I'm not sure about their situation.

also o2micro might also create pcmcia card readers for either.
maybe let us know what kind of device you exactly have and how
it is connected (if build in... lspci / lsusb would see pci or
usb devices, pcmcia devices are found by the kernel I think).

Regards, Andreas

