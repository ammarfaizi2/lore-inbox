Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbVIHVRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbVIHVRu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbVIHVRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:17:50 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:63421
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1751407AbVIHVRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:17:49 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Bharath Ramesh'" <krosswindz@gmail.com>, "'Pavel Machek'" <pavel@ucw.cz>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: IPW2100 Kconfig
Date: Thu, 8 Sep 2005 15:17:38 -0600
Message-ID: <008501c5b4ba$be1a7990$a20cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
In-Reply-To: <c775eb9b05090814114f258dc9@mail.gmail.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> AFAIK hotplug looks for firmware in /lib/firmware and not
> /etc/firmware.
>
> On 9/8/05, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > >       I checked the IPW2100 in the current git from
> linux-2.6 and the menuconfig
> > > help (Kconfig) says you need to put the firmware in
> /etc/firmware, it should
> > > be /lib/firmware.
> > >
> > > Who should I send the "patch" to? Or can someone simply
> change that?
> >
> > Are you sure it is not distro-dependend?
> > --

Right, IPW2100 came with Legacy fw load first. Maybe that was dragged from
long time ago and used incorrectly.

I'm 100% sure that new versions of hotplug try to look at /lib/firmware and
was /usr/lib/hotplug/firmware before, but there was some discussion that
/lib would make more sense cause /usr could be dependant on other stuff.

Jesper already signed the patch.

.Alejandro

