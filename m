Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268164AbUIPR2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268164AbUIPR2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268215AbUIPR2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:28:39 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:12229 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S268334AbUIPR2U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:28:20 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: arjanv@redhat.com
Subject: Re: 2.6.9-rc2-mm1
Date: Thu, 16 Sep 2004 14:28:10 -0300
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040916024020.0c88586d.akpm@osdl.org> <200409161345.56131.norberto+linux-kernel@bensa.ath.cx> <1095354962.2698.22.camel@laptop.fenrus.com>
In-Reply-To: <1095354962.2698.22.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161428.10717.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2004-09-16 at 18:45, Norberto Bensa wrote:
> > Andrew Morton wrote:
> > > +tune-vmalloc-size.patch
> >
> > This one of course breaks nvidia's binary driver; so nvidia users should
> > do a "patch -Rp1" to revert it.
>
> eh why how ?? what evil stuff is nvidia doing this time ?

On modprobe it says: "__VMALLOC_RESERVE undefined symbol". I'm almost sure is 
an #include thing, but since I know near to nothing about the kernel 
internals, I prefer to revert the patch.

Now I got this problem with vmware but I need a reboot to tell you the exact 
message; if you are interested, I'll report later.

Best regards,
Norberto

