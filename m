Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278739AbRJVLsJ>; Mon, 22 Oct 2001 07:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278736AbRJVLsA>; Mon, 22 Oct 2001 07:48:00 -0400
Received: from t2.redhat.com ([199.183.24.243]:12279 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S278735AbRJVLrs>; Mon, 22 Oct 2001 07:47:48 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <hwHwJtbLMA17Ew7i@wookie.demon.co.uk> 
In-Reply-To: <hwHwJtbLMA17Ew7i@wookie.demon.co.uk>  <NPHLGxZPH$07EwlQ@wookie.demon.co.uk> <4947.1003748210@redhat.com> 
To: John Beardmore <wookie@wookie.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ISDN cards and SMP 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Oct 2001 12:48:04 +0100
Message-ID: <11288.1003751284@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



wookie@wookie.demon.co.uk said:
>  This is hisax.  What version are you using ?  Maybe it's been sorted
> in  the last year or so ? 

I've used the 2.2 kernels shipped with Red Hat 7.0 and 7.1, briefly. This 
box has been running various 2.4 kernels since 2.4.0-test10, and is now 
running the Red Hat 7.2 release kernel. None of them have had any ISDN 
problems.

>  I've built it from the sources that shipped with RH 6.2 using the GUI
>  tool to specify SMP support.  I think it's installed properly in as
> far  as all three CPUs get used once its installed.  Very cute !  Roll
> over  NT etc !

Why rebuild? An SMP kernel is shipped, with matching modules etc.

> > If you're building your own, rebuild it and the modules.
> I can do, but I'd like to know what to do differently first. 

Difficult to say, without actually having seen the error you're getting. 
Try turning CONFIG_MODVERSIONS off and rebuilding both kernel and modules, 
for a start.

--
dwmw2


