Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUJTVFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUJTVFD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 17:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270563AbUJTU74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:59:56 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:31195 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270553AbUJTU6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:58:42 -0400
Subject: Re: forcing PS/2 USB emulation off
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <orbrezdgis.fsf@livre.redhat.lsd.ic.unicamp.br>
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <200410172248.16571.dtor_core@ameritech.net>
	 <20041018164539.GC18169@kroah.com>
	 <orbrezdgis.fsf@livre.redhat.lsd.ic.unicamp.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098302140.12366.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 20 Oct 2004 20:55:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-10-18 at 19:31, Alexandre Oliva wrote:
> > Is there any consistancy with the type of hardware that you see being
> > reported for this issue?
> 
> I've googled around and found a lot of reports of such issues on the
> HP Presario 3000Z series, as well as some other HP notebook series
> (nx5000?) that (kind of :-) supports Athlon64 processors.

The main problem ones in Red Hat bugzilla are anythign E7xxx based (this
seems to be the department of lost causes), but which has a "fix" akin
to Greg's for UHCI only and the HP (and other eMachines identical)
laptops which is fixed by BIOS updating to the newer model (warranty and
risk your own...)

Alan

