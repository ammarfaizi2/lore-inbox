Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267166AbTGTNwM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 09:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbTGTNwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 09:52:12 -0400
Received: from helios.univ-reunion.fr ([194.199.73.1]:61666 "EHLO
	helios.univ-reunion.fr") by vger.kernel.org with ESMTP
	id S267166AbTGTNwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 09:52:10 -0400
Message-ID: <1058709990.3f1aa1e68771a@imp.univ-reunion.fr>
Date: Sun, 20 Jul 2003 18:06:30 +0400
From: Alain.BASTIDE@univ-reunion.fr
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Alain.BASTIDE@univ-reunion.fr, linux-kernel@vger.kernel.org
Subject: Re: Trans.: Re: AMD Athlon MP Machine check exceptions
References: <1058703292.3f1a87bcc6b1a@imp.univ-reunion.fr> <20030720125019.GC628@gallifrey>
In-Reply-To: <20030720125019.GC628@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2
X-Originating-IP: 10.10.6.196
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,


   i found !!!
   SENSORS_W83781D had to set to : n and not y 
   after it work!!!

bye


Quoting "Dr. David Alan Gilbert" <gilbertd@treblig.org>:

> * Alain.BASTIDE@univ-reunion.fr (Alain.BASTIDE@univ-reunion.fr) wrote:
> > Hi 
> 
> Hi Alain,
> 
> >  i had the same problem whith a MSI 6501 AMD MP 2000+!!!! and now it's
> worked!!!!
> > 
> >  I compile one kernel and when i start  mbmon (
> > http://www.nt.phys.kyushu-u.ac.jp/shimizu/download/download.html ) 
> > 
> > i saw 
> > Temp.= 32.0, 73.5, 65.5; Rot.= 2596, 4821, 2636
> > Vcore = 1.66, 2.54; Volt. = 3.34, 4.84, 12.40, -12.78, -5.00
> 
> There were known problems with temperature measurements on some Athlon
> MP systems where two different programs report temperatures 30deg apart
> - so it is never obvious what to believe!
> 
> 
> > it was amazing cause bios said ~40°C
> > 
> >  I compile a new kernel where i change options and now i haven't  got this
> > message and mbmon say :
> 
> Which options?
> 
> Dave
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
> \ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
> 




-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
