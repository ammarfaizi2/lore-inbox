Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVA0QTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVA0QTX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbVA0QTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:19:23 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:22416 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262401AbVA0QTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:19:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=WkE08RtKWZ9EUKdgCOQ2zI1tiu4ZO9lWY16fT2r76fiANLY4NUJD53cbHmRR92iITdL7k1ATJRvX8RlMikBS6RQbFbD76qEQrh27OWwHc97Ade1B8CZAY0Gbn9j9Uk5OuvdmgZ7cpcJ+ceAEaBSV9sCC6kwAB8hwRgwC0AZPukA=
Message-ID: <5b64f7f050127081948af7a31@mail.gmail.com>
Date: Thu, 27 Jan 2005 11:19:20 -0500
From: Rahul Karnik <deathdruid@gmail.com>
Reply-To: Rahul Karnik <deathdruid@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Flashing BIOS of a PCI IDE card (IT8212F)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was just wondering if it is possible to flash the BIOS of a PCI IDE
card from within Linux. I have an OEM IT8212 card with a really old
BIOS which the vendor does not support with a BIOS flashing tool. ITE
Tech's flashing tool appears to work, but it fails to verify that the
flash was successful and indeed the ROM is unchanged.

How is the BIOS on such cards different from the firmware on other
cards? Is it possible to use the kernel firmware loader to load a
different image at runtime?

Thanks for the help,
Rahul
