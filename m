Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278236AbRJSATr>; Thu, 18 Oct 2001 20:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278237AbRJSATi>; Thu, 18 Oct 2001 20:19:38 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:40428 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278236AbRJSATa>; Thu, 18 Oct 2001 20:19:30 -0400
Date: 19 Oct 2001 00:10:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8BBKUgOHw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.21.0110180826240.16868-100000@marty.infinity.powertie.org>
Subject: Re: [RFC] New Driver Model for 2.5
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20011018121318.17949@smtp.adsl.oleane.com> <Pine.LNX.4.21.0110180826240.16868-100000@marty.infinity.powertie.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mochelp@infinity.powertie.org (Patrick Mochel)  wrote on 18.10.01 in <Pine.LNX.4.21.0110180826240.16868-100000@marty.infinity.powertie.org>:

> > I would add to the generic structure device, a "uuid" string field.
> > This field would contain a "munged" unique identifier composed of
> > the bus type followed which whatever bus-specific unique ID is
> > provided by the driver. If the driver don't provide one, it defaults
> > to a copy of the busID.
> >
> > What I have in mind here is to have a common place to look for the
> > best possible unique identification for a device. Typical example are
> > ieee1394 hard disks which do have a unique ID, and so can be properly
> > tracked between insertion removal.
>
> Hmm. So, this would be a device ID, much like the Vendor/Device ID pair in
> PCI space?

Except for the fact that the Vendor/Device ID pair is a device *class*  
identifier, and the uuid is a device *instance* identifier.


MfG Kai
