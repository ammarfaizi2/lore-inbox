Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbTFMI0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbTFMI0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:26:47 -0400
Received: from [80.190.106.4] ([80.190.106.4]:36618 "EHLO mail.taytron.net")
	by vger.kernel.org with ESMTP id S265251AbTFMI0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:26:46 -0400
From: "Florian Schirmer" <jolt@tuxbox.org>
To: <linux-kernel@vger.kernel.org>
Cc: <alan@lxorguk.ukuu.org.uk>, <duvall@emufarm.org>
Subject: Re: RTC causes hard lockups in 2.5.70-mm8
Date: Fri, 13 Jun 2003 10:40:28 +0200
Message-ID: <000001c33187$71cca990$0100a8c0@space.taytron.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Alan asked whether it was a specific in or out instruction in the 
> driver, but I don't know how to find out.

rtc_read never returns. It is busy waiting for a rtc interrupt to arrive.
Which will never do... I blaim ACPI, as it works fine with acpi=off.

Regards,
  Florian

