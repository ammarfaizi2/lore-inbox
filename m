Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265764AbUGTPuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUGTPuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 11:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUGTPuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 11:50:07 -0400
Received: from mail1.upco.es ([130.206.70.227]:36540 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S265764AbUGTPuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 11:50:02 -0400
Date: Tue, 20 Jul 2004 17:50:00 +0200
From: Romano Giannetti <romano@dea.icai.upco.es>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: swsuspend not working
Message-ID: <20040720155000.GA27688@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040715121042.GB9873@lps.ens.fr> <20040715121825.GC22260@elf.ucw.cz> <20040715132348.GA9939@lps.ens.fr> <20040719191906.GA7053@lps.ens.fr> <20040720131748.GI27492@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20040720131748.GI27492@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 03:17:48PM +0200, Pavel Machek wrote:

> > If, instead of unloading/reloading the modules, I unplug and replug the
> > radio emiter of the mouse, I get it back working. If I unplug the memory
> > key, the device REMAINS as managed by the ehci controller. If I plug it
> > back again, the memory key appears A SECOND TIME in the list of usb
> > device, but as an uhci device, this time.
> 
> Ok, someone needs to fix usb.
> 

I can confirm that USB has troubles with suspend/resume (I have a Sony vaio
laptop; http://perso.wanadoo.es/r_mano/vaio/vaio.html ). Especially the
memory key; the only way to not have to reboot to have it is suspending with
the key umounted. 

On the bright side, I doscovered that current (2.6.7) kernel pcmcia and alsa
sound behave perfectly w/ respect of suspend/resume. No need to cardctl
eject before and insert after, my modem continue working after resume; and I
can even suspend with xmms playing and on resume it will continue happily. 

Nice work, a kudo to all! 

Romano 

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
