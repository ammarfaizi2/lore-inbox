Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318088AbSHDEYR>; Sun, 4 Aug 2002 00:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318093AbSHDEYR>; Sun, 4 Aug 2002 00:24:17 -0400
Received: from mk-smarthost-2.mail.uk.tiscali.com ([212.74.114.38]:20235 "EHLO
	mk-smarthost-2.mail.uk.tiscali.com") by vger.kernel.org with ESMTP
	id <S318088AbSHDEYR>; Sun, 4 Aug 2002 00:24:17 -0400
X-Mailer: exmh version 2.5 07/13/2001 (debian 2.5-1) with nmh-1.0.4+dev
To: Brian Gerst <bgerst@didntduck.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Weber <john.weber@linux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Toshiba Laptop Support and IRQ Locks 
In-Reply-To: Message from Brian Gerst <bgerst@didntduck.org> 
   of "Fri, 02 Aug 2002 15:49:06 EDT." <3D4AE232.6010000@didntduck.org> 
References: <3D4AAD53.7010008@linux.org> <1028310939.18309.93.camel@irongate.swansea.linux.org.uk> <E17aiHh-00034N-00@jelly.buzzard.org.uk>  <3D4AE232.6010000@didntduck.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Aug 2002 05:27:41 +0100
From: Jonathan Buzzard <jonathan@buzzard.org.uk>
Message-Id: <E17bCzV-0000Ri-00@jelly.buzzard.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



bgerst@didntduck.org said:
> > Two things to bare in mind, Toshiba have yet to do any sort of
> > multi processor laptop, are extremely unlikely to ever manufacture
> > one, and to the best of my knowledge the module only loads on Toshiba
> > laptops. If it loads on anything else it is broken and needs fixing
> > so it does not.
>
> What about P4 Hyperthreading? 

The cli() and associated code in the toshiba SMM driver is for laptops
manufactured prior to 1999. It is not relevant and never will be on
any laptop with a P4 processor in it. For that matter it is not
even relevant on a PIII or PII processor. It is strictly Pentiums and
486's.

JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan@buzzard.org.uk
Northumberland, United Kingdom.       Tel: +44(0)1661-832195


