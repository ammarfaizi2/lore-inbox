Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287317AbSAGWax>; Mon, 7 Jan 2002 17:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287313AbSAGWad>; Mon, 7 Jan 2002 17:30:33 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:64182 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S287297AbSAGWa0>; Mon, 7 Jan 2002 17:30:26 -0500
Date: Mon, 07 Jan 2002 14:28:38 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>, mochel@osdl.org
Message-id: <17d401c197ca$a78e66c0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <20020107192903.GB8413@kroah.com>
 <17b801c197ba$febd13c0$6800000a@brownell.org> <20020107220348.GE9271@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hopefully, integration of /sbin/hotplug during the boot process (using
> dietHotplug) will reduce the number of things the "coldplug" issue will
> have to handle.

Somewhat -- though it only handles the "load a module"
subproblem.  When new devices need any more setup
than that, "dietHotplug" isn't enough.

- Dave


