Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTEPWAd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 18:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTEPWAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 18:00:33 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:34268 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262111AbTEPWAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 18:00:32 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: request_firmware() hotplug interface, third round.
Date: Sat, 17 May 2003 00:13:49 +0200
User-Agent: KMail/1.5.1
Cc: ranty@debian.org, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
References: <20030515200324.GB12949@ranty.ddts.net> <200305161007.31335.oliver@neukum.org> <1053101342.5589.5.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1053101342.5589.5.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305170013.49808.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 16. Mai 2003 18:09 schrieb Alan Cox:
> On Gwe, 2003-05-16 at 09:07, Oliver Neukum wrote:
> > So, if I understand you correctly, RAM is only saved if a device
> > is hotpluggable and needs firmware only upon intial connection.
> > Which, if you do suspend to disk correctly, is no device.
>
> Thats just because the interface is a little warped not the theory.
> On a resume you need to reload firmware and you already handle
> rediscovery on USB bus for example because the devices can change

Right. But the order of resumption is fixed by hardware needs.
So during resumption you cannot use block devices and therefore
not start a hotplug script. Or did I miss something?

	Regards
		Oliver

