Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbTIEVcN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264837AbTIEVcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:32:13 -0400
Received: from cm68240.red.mundo-r.com ([213.60.68.240]:3200 "EHLO
	euclides.hn.org") by vger.kernel.org with ESMTP id S262937AbTIEVcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:32:12 -0400
From: Momes <momes@mundo-r.com>
To: Greg KH <greg@kroah.com>
Subject: Re: USB hang
Date: Fri, 5 Sep 2003 23:32:09 +0200
User-Agent: KMail/1.5.3
References: <200309041951.37523.momes@mundo-r.com> <20030905160815.GA1946@kroah.com>
In-Reply-To: <20030905160815.GA1946@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309052332.10022.momes@mundo-r.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 September 2003 18:08, Greg KH wrote:
> On Thu, Sep 04, 2003 at 07:51:37PM +0200, Momes wrote:
> > Hello:
> > I'm trying to compile new kernel 2.4.22 (with XFS patch) in my machine.
> > The problem is that it always hangs when I plug in my USB keyboard.
> > My system needs "noapic" option in lilo.conf but it has always worked
> > fined up to kernel 2.4.21. I've searched the archives and also used
> > Google without found any answer, so decided to post my problem in the
> > list with the hope that someone can give some clue.
> >
> > The system always stops at this point:
> >
> > "input: USB HID v1.00 Keyboard [BTC USB Keyboard] on usb2:3.0"
>
> If you boot without any USB devices plugged in, and then plug them in
> after boot, do you still have this problem?
>
> And does this happen without the XFS patch?
>
> thanks,
>
> greg k-h
> -


When system boots with no  USB device plugged in everything works OK until
the moment I plug a USB device. In that very moment the system freezes with 
message

"input: USB HID v1.00 Keyboard [BTC USB Keyboard] on usb2:3.0"

as reported before.
As you suggested I've also tried the vanila kernel without the XFS patch 
without any difference. System remains hanging.

Any idea?

Thank you very much.
				Momes
