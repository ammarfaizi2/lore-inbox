Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269198AbUJUQrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269198AbUJUQrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268889AbUJUQq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:46:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48863 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269198AbUJUQpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:45:32 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: forcing PS/2 USB emulation off
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br>
	<200410172248.16571.dtor_core@ameritech.net>
	<20041018164539.GC18169@kroah.com>
	<orbrezdgis.fsf@livre.redhat.lsd.ic.unicamp.br>
	<1098302140.12366.42.camel@localhost.localdomain>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 21 Oct 2004 13:45:17 -0300
In-Reply-To: <1098302140.12366.42.camel@localhost.localdomain>
Message-ID: <orlle058bm.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 20, 2004, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Llu, 2004-10-18 at 19:31, Alexandre Oliva wrote:
>> > Is there any consistancy with the type of hardware that you see being
>> > reported for this issue?
>> 
>> I've googled around and found a lot of reports of such issues on the
>> HP Presario 3000Z series, as well as some other HP notebook series
>> (nx5000?) that (kind of :-) supports Athlon64 processors.

> The main problem ones in Red Hat bugzilla are anythign E7xxx based (this
> seems to be the department of lost causes), but which has a "fix" akin
> to Greg's for UHCI only and the HP (and other eMachines identical)
> laptops which is fixed by BIOS updating to the newer model (warranty and
> risk your own...)

Updating the BIOS doesn't actually fix my (Presario r3004).  The
Errata #93 message become less common, but aren't completely gone, and
the touchpad isn't recognized either way.  FWIW, a BIOS upgrade to my
wife's box (a supposed-to-be-identical notebook) makes the clock 3x
too fast.  So upgrading the BIOS, even if it fixed the USB hand-off
problem, would make the box unusable for this other problem.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
