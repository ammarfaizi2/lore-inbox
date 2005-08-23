Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVHWQbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVHWQbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 12:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVHWQbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 12:31:11 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:59869 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932217AbVHWQbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 12:31:10 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: rol@witbe.net
Subject: Re: [2.4.31] - USB device numbering in /proc/bus/usb
Date: Tue, 23 Aug 2005 17:31:09 +0100
User-Agent: KMail/1.8.90
Cc: "'Sergey Vlasov'" <vsu@altlinux.ru>, linux-kernel@vger.kernel.org
References: <200508231551.j7NFpFD00513@tag.witbe.net>
In-Reply-To: <200508231551.j7NFpFD00513@tag.witbe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508231731.09099.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 August 2005 16:51, Paul Rolland wrote:
> Hello Sergey,
>
> > Yes.  Addresses for USB devices are assigned dynamically.  If you
> > disconnect the modem from USB and connect it again, its address will
> > change.
>
> The problem I've is that nothing changed on the machine except that
> I did a reboot. Nothing (USB device) added, nothing removed, so with
> a stable hardware config, USB numbering should have stayed stable, IMHO.

Basically, no it shouldn't.

>
> > > I would have been expecting some more stability in the
> >
> > numbering across
> >
> > > reboot, the same way IDE disks numbers are stable.
> >
> > Use some other identifier which is stable - e.g., serial number of the
> > USB device (unfortunately, many devices don't have it).
>
> Well yes, I'm going to try to convert to some other identifiers space
> as this seems to be the only way to go.
>
> Thanks for the confirmation,
> Regards,
> Paul

/proc/bus/usb/devices (which tells you where a device is located in the tree). 
This should work on 2.4 kernels, 2.6 kernels should be using sysfs by now.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
