Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280923AbRKCCD3>; Fri, 2 Nov 2001 21:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280925AbRKCCDT>; Fri, 2 Nov 2001 21:03:19 -0500
Received: from hermes.toad.net ([162.33.130.251]:60894 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S280923AbRKCCDJ>;
	Fri, 2 Nov 2001 21:03:09 -0500
Subject: Re: 2.4.12-ac3 floppy module requires 0x3f0-0x3f1 ioports
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org,
        Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 02 Nov 2001 21:02:28 -0500
Message-Id: <1004752951.1104.4.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Maciej Zenczykowski wrote:
>> Is there any reason why the floppy module requires
>> the ioport range 0x3f0-0x3f1 in order to load?  On
>> my computer /proc/ioports reports this range as used
>> by PnPBIOS PNP0c02, thus the floppy module cannot
>> reserve the range 0x3f0-0x3f5 and refuses to load.
>
> This is a bug in the PnPBIOS experimental code -
> turn off PnPBIOS and/or update for the moment

A fix for this problem went in to 2.4.13-ac2.  Please
try that kernel (or a later -ac kernel) and report back.

--
Thomas

