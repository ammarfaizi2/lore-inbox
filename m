Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUIAN6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUIAN6w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUIAN6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:58:52 -0400
Received: from tag.witbe.net ([81.88.96.48]:59296 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S266646AbUIAN6p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:58:45 -0400
Message-Id: <200409011358.i81Dweq17997@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Romain Moyne'" <aero_climb@yahoo.fr>, "'Dave Jones'" <davej@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Time runs exactly three times too fast
Date: Wed, 1 Sep 2004 15:58:23 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSQJSdBxcC300I7TU+iHebOiW50jgABoyRA
In-Reply-To: <200409021831.55002.aero_climb@yahoo.fr>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Try rebuilding your kernel _without TSC_...

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it" 

  

> -----Message d'origine-----
> De : linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] De la part de Romain Moyne
> Envoyé : jeudi 2 septembre 2004 18:32
> À : Dave Jones; linux-kernel@vger.kernel.org
> Objet : Re: Time runs exactly three times too fast
> 
> Le Mercredi 01 Septembre 2004 15:00, Dave Jones a écrit :
> > On Thu, Sep 02, 2004 at 05:08:30PM +0200, Romain Moyne wrote:
> >  > >Do you have files in /sys/devices/system/cpu/cpu0/cpufreq ?
> >  >
> >  > I don't.
> >
> > what about after modprobe powernow-k8 ?
> > (that should also print out some messages in dmesg)
> 
> powernow-k8 is for athlon64, no ? I have just compiled in the 
> kernel (not as a 
> module) the option powernow-k7 (I have a Athlon XP-M).
> So, I can't do modprobe powernow-k7...
> 
> 
> >
> >   Dave
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

