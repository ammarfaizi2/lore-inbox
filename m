Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUFQI4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUFQI4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 04:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266426AbUFQI4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 04:56:05 -0400
Received: from aun.it.uu.se ([130.238.12.36]:60044 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266436AbUFQIzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 04:55:55 -0400
Date: Thu, 17 Jun 2004 10:55:46 +0200 (MEST)
Message-Id: <200406170855.i5H8tk15012560@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: andre@tomt.net, root@chaos.analogic.com
Subject: Re: Programtically tell diff between HT and real
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004 17:58:26 -0400 (EDT), Richard B. Johnson wrote:
>> > I would love to know how you turn in on! This is one of those
>> > "latest-and-greatest" Intel D865PERL mother-boards and I've
>> > even flashed the BIOS with the "latest-and-greatest".
>>
>> The usual way is to enable HT in BIOS, and use a SMP enabled kernel.
>>
>
>It's a SMP kernel. There is no 'HT enable' in the BIOS setup.
>In fact, there is very little that can be set and, it's even
>very hard to convince it that I want to boot from a SCSI and
>not from the first disk it finds. One has to remove the battery
>to discharge the CMOS so it won't ignore the 'Del' key
>on startup. It's a very bad BIOS or a very bad board, I
>don't know which.

Or you forgot to enable ACPI in the kernel.
For some reason, the MP tables aren't capable of
describing HT siblings, so the BIOSen do that
via the ACPI tables instead.
