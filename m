Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270430AbTHQQmH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270432AbTHQQmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:42:07 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:29451 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S270430AbTHQQmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:42:02 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Date: Sun, 17 Aug 2003 20:41:31 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200307262036.13989.arvidjaar@mail.ru> <200307282044.43131.arvidjaar@mail.ru> <20030728170308.GA4839@kroah.com>
In-Reply-To: <20030728170308.GA4839@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308172041.31874.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 July 2003 21:03, Greg KH wrote:
[...]
> > Question: how to configure udev so that "database" always refers to LUN 0
> > on target 0 on bus 0 on HBA in PCI slot 1.
>
> If you can't rely on scsi position, then you need to look for something
> that uniquely describes the device.  Like a filesystem label, or a uuid
> on the device.  udev can handle this (well I'm still working on the
> filesystem label, but others have already done the hard work for that to
> be intregrated easily.)
>

I tried to explain that I can rely on SCSI position but kernel does not give 
me this SCSI position. Apparently we have some communication problem. You do 
not understand my question and I do not understand what you do not understand 
:) I attribute it to my bad English.

Let's avoid this communication problem. You show me namedev.config line that 
implements the above. If it really does it - it is likely I understand what 
you mean better and won't bother you with stupid questions anymore. If it 
does not do it - I can immediately point out where it fails.

OK?

thank you

-andrey
