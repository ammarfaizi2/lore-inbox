Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbTIHKN2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 06:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTIHKN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 06:13:28 -0400
Received: from lidskialf.net ([62.3.233.115]:3540 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S262255AbTIHKN1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 06:13:27 -0400
From: Andrew de Quincey <adq@lidskialf.net>
To: pinotj@club-internet.fr, linux-kernel@vger.kernel.org
Subject: Re: [BUG?] usb won't work with kernel 2.4.22
Date: Mon, 8 Sep 2003 11:11:55 +0100
User-Agent: KMail/1.5.3
References: <mnet3.1062999418.2284.pinotj@club-internet.fr>
In-Reply-To: <mnet3.1062999418.2284.pinotj@club-internet.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309081111.55331.adq@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 Sep 2003 11:36 am, pinotj@club-internet.fr wrote:
> From: Sven_Köhler <>
>
> >Subject: [BUG?] usb won't work with kernel 2.4.22
> >Date Mon, 08 Sep 2003 04:20:15 +0200
>
> [...]
>
> >After upgrading from 2.4.21 to 2.4.22 my USB doens't work anymore.
>
> lsusb doesn't show any devices - find /proc/bus/usb too.
> [...]
>
> I got the same probleme with K7S5A/SiS735 and it doesn't come from USB.
> I found that the acpi upgrade between 2.4.22-rc2 and 2.4.22-rc3 break the
> USB detection. I made a fall-back diff about this. I discussed about this
> with Andrew de Quincey on acpi mailing-list. His last acpi global patch
> correct this problem too but I don't know if it will be implemented.

It should be there eventually, the core ACPI guys understandably decided to 
keep it back for some more testing because one bit of it was quite large.

