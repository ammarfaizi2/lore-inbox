Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVJQTJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVJQTJW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVJQTJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:09:22 -0400
Received: from web50211.mail.yahoo.com ([206.190.39.175]:34989 "HELO
	web50211.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932277AbVJQTJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:09:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6R8vEIG0hfaIGC+iySLE4oeRfIzw4LmOqmJR3+p3mjSm+YPMHkdEmgSdovViNW9g+EK97jx03MQnRvgiJhcnJEEXdF0d7Y5fjY/5lkVIOTVMBbstWztmPMai3BQpZShX8/qPt4gapsuItSAgKasuXwVipKW/dXmPpbkuJM3AnYw=  ;
Message-ID: <20051017190918.7670.qmail@web50211.mail.yahoo.com>
Date: Mon, 17 Oct 2005 12:09:18 -0700 (PDT)
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [ACPI] Re: [patch 0/2] acpiphp: hotplug adapters with bridges on them
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1129570906.28798.5.camel@whizzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Kristen Accardi <kristen.c.accardi@intel.com> wrote:

> On Thu, 2005-10-13 at 14:29 +0300, Paul Ionescu wrote:
> > On Fri, 07 Oct 2005 10:45:45 -0700, Kristen Accardi wrote:
> > 
> > > These 2 patches will allow adapters with p2p bridges on them to be
> > > successfully hotplugged using the acpiphp driver.  Currently, if you
> > > attempt to hotplug an adapter with a p2p bridge on it, the operation will
> > > fail because resources are not allocated to it properly.  These patches
> > > have had very limited testing as I only have one machine and one type of
> > > adapter to test this with.  I tested this with 2.6.14-rc2, but the patch
> > > applies fine to rc3 as well.
> > 
> > Is this patch supposed to allow me to hot-plug/hot-eject my laptop in its
> > docking station ?
> 
> 
> Hi Paul,
> Actually, I did this patch as part of the work I'm doing to enable
> docking station support.  It is necessary for docking station, however,
> it isn't the only thing that is needed to get docking station to work.
> The docking station patch is in progress still - and will hopefully be
> ready for testing soon.
> 
> Kristen

Hi Kristen,

Thanks for the info.
Just let me know when your docking station support patch is ready, and maybe I can help with
testing.

Regards,
Paul

> 
> > I have an IBM T41 and a docking station with extra IDE/PCI/PCMCIA bus-es on it.
> > I've tried for a long time to make them work hot, but till now, I could
> > not make them work.
> > I can only use the docking station if I boot in it.
> > 
> > Thanks,
> > Paul



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
