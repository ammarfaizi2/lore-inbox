Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVAJMdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVAJMdl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 07:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVAJMdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 07:33:41 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:7118 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S262221AbVAJMdi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 07:33:38 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-22.tower-45.messagelabs.com!1105360416!9146681!1
X-StarScan-Version: 5.4.5; banners=-,-,-
X-Originating-IP: [66.10.26.57]
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: Linux 2.6.10 under VMware - NULL pointer.
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Mon, 10 Jan 2005 07:33:35 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC425F@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: Linux 2.6.10 under VMware - NULL pointer.
thread-index: AcT1yb925V2n2jU6RFy6rWh/5LcKlwBRnEYw
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: <znmeb@cesmail.net>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Questions:
> 1. Is the VMWare host Windows or Linux?
The VMWare host is Windows XP SP2.

> 2. Is the distribution of Linux you are attempting to run as a guest
one
> that is supported by VMWare?
Previously, it was Slackware and now Debian, not "officially supported."
But I never had any problem with kernels 2.6.5-2.6.9 with either
distribution.

> 3. Are you using the latest version of VMWare?
Yes, I am using the latest stable.

-----Original Message-----
From: M. Edward Borasky [mailto:znmeb@cesmail.net] 
Sent: Saturday, January 08, 2005 4:32 PM
To: Piszcz, Justin Michael
Subject: Re: FW: Linux 2.6.10 under VMware - NULL pointer.

On Tue, 2005-01-04 at 10:49 -0500, Piszcz, Justin Michael wrote:
> At first, I thought these problems may have been related to XFS;
however, I am now using ext2 and they still persist.
> 
> Under the same Virtual Machine, Slackware-9.1, 10 & -current worked OK
with kernels 2.6.5-2.6.9.
> 
> The current distribution I am running is Debian Sarge 3.1rc2 with
2.6.10.
> 
> Any ideas?

Questions:

1. Is the VMWare host Windows or Linux?
2. Is the distribution of Linux you are attempting to run as a guest one
that is supported by VMWare?
3. Are you using the latest version of VMWare?

VMWare is a commercial, licensed product. I have a license (Windows XP
Host), but I haven't done much with it recently, mostly because the
machine in question is now a *real* dual-boot and it doesn't really have
enough RAM to support a Linux guest in the manner to which Linux is
accustomed. :)

When I was using VMWare with Linux guests, however, my recollection is
that Red Hat Linux was supported; everything else was "roll your own". I
was able to get Debian "woody", Knoppix LiveCDs and hard disk installs
to work easily as guests. A little more hacking was required with
Gentoo, because of the different way Gentoo handles "/etc/init.d".

If I run out of more interesting things to do this weekend, I might
upgrade my VMWare to the latest stable and try to load Gentoo 2004.3 as
a guest with a 2.6 kernel, just to see what happens. I have Gentoo's
2.6.10-r3 running on all of my Linux boxes. I had one panic with
2.6.10-r1, but no events of any kind since that.

Ed Borasky

