Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSFRHds>; Tue, 18 Jun 2002 03:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317353AbSFRHdr>; Tue, 18 Jun 2002 03:33:47 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:46860 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317349AbSFRHdq>; Tue, 18 Jun 2002 03:33:46 -0400
Message-ID: <3D0EE24D.DABA5C69@aitel.hist.no>
Date: Tue, 18 Jun 2002 09:33:33 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.20-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Raphael Manfredi <Raphael_Manfredi@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: The buggy APIC of the Abit BP6
References: <004901c213c3$7a73b8f0$020da8c0@nitemare> <aeddc2$jva$1@lyon.ram.loc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael Manfredi wrote:
> 
> Quoting Robbert Kouprie <robbert@radium.jvb.tudelft.nl> from ml.linux.kernel:
> :BTW, did you get any explanation why this wasn't applied in -ac or main
> :kernel?
> 
> None.
> 
> But I know that this patch is dirty because it attacks a hardware-dependent
> layer from a rather generic one.  This may be why it's rejected.  And it
> may also be completely APIC-BP6 specific.
> 
> I also know is that it works for me. ;-)

I'll try it.  Have you considered resubmitting the patch,
hidden behind a CONFIG_BROKEN_APIC?  That'll keep the code
clean for those with better hardware.

Helge Hafting
