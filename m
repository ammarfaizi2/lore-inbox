Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbUATFHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 00:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUATFHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 00:07:15 -0500
Received: from gw.mgpenguin.net ([150.101.216.218]:16264 "EHLO
	mail.mgpenguin.net") by vger.kernel.org with ESMTP id S264394AbUATFHO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 00:07:14 -0500
Message-Id: <5.1.0.14.2.20040120160408.00b184f8@mail.mgpenguin.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 20 Jan 2004 16:07:12 +1100
To: Greg KH <greg@kroah.com>
From: Kieran Morrissey <linux@mgpenguin.net>
Subject: Re: [PATCH] 2.6.1: Update PCI Name database, fix gen-devlist.c
  for long device names.
Cc: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20040120013042.GG6309@kroah.com>
References: <20040117103859.GA2185@ucw.cz>
 <5.1.0.14.2.20040115140515.00af1318@mail.mgpenguin.net>
 <20040117103859.GA2185@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; x-avg-checked=avg-ok-5BE930BD; boundary="=======5C1D45DA======="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=======5C1D45DA=======
Content-Type: text/plain; x-avg-checked=avg-ok-5BE930BD; charset=us-ascii
Content-Transfer-Encoding: 8bit

At 05:30 PM 19/01/2004 -0800, you wrote:

>On Sat, Jan 17, 2004 at 11:39:00AM +0100, Martin Mares wrote:
>> Hello!
>> 
>> > * Updates pci.ids with a snapshot from http://pciids.sourceforge.net/ as at 
>> > 14 Jan 04.
>> > * Fixes gen-devlist.c to truncate long device names rather than reject the 
>> > whole database
>> >   (previously the latest databases had some devices that were too long and 
>> > caused a kernel with the latest db to fail to compile)
>> 
>> I think it would be better to increase the name length limit, the long entries
>> really have useful information at the end :)
>
>That's probably a good idea.  Kieran, care to make up a patch to do
>this?
>
>thanks,
>
>greg k-h

Done (see other message).. but does anyone know why the name size limit was introduced in 2.5? Saving memory? (all of 30-odd bytes per device, say 480 bytes in an average system? seems silly to reduce functionality that much to achieve such a tiny space saving; I mean it's understandable perhaps on an embedded system, but you wouldn't be compiling the database in then :)

Cheers

        Kieran

--=======5C1D45DA=======--

