Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274203AbRISWGT>; Wed, 19 Sep 2001 18:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274206AbRISWGB>; Wed, 19 Sep 2001 18:06:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57605 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274203AbRISWFr>; Wed, 19 Sep 2001 18:05:47 -0400
Subject: Re: Replace the eepro100 driver with the e100 driver??
To: greearb@candelatech.com (Ben Greear)
Date: Wed, 19 Sep 2001 23:10:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3BA90EF2.527C9A50@candelatech.com> from "Ben Greear" at Sep 19, 2001 02:32:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jpY9-0003zb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The e100 license appears to be compatible, and it has some nice features, like

Compatible but unsafe. Its no longer safe to accept BSD licensed code into
the Linux kernel because of the US patent law situation (the GPL prevents
someone patenting things, feeding them into Linux under the GPL then sueing
everyone who uses it - BSD does not). On that issue there is a patent 
licensing proposal from intel that may resolve it.

> interrupt-cooelescing that I don't think are supported in the eepro100..
> I keep thinking that if everyone could get behind a single driver,
> especially one with corporate support, we may have a more stable
> result...

We have been trying for a very very long time to get intel to help with
the mainstream driver. The mainstream driver doesnt contain huge delay 
loops, is written in a way linux folk understand and is rather cleaner
[IMHO]. It is unfortunate Intel wouldnt help out with the kernel driver but
that is their policy it seems.

Alan
