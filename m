Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281197AbRKHAno>; Wed, 7 Nov 2001 19:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281203AbRKHAng>; Wed, 7 Nov 2001 19:43:36 -0500
Received: from smtp5.wanadoo.es ([62.37.236.139]:1531 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id <S281197AbRKHAnP>;
	Wed, 7 Nov 2001 19:43:15 -0500
Date: Thu, 8 Nov 2001 01:36:25 +0100
From: drizzt.dourden@iname.com
To: LLX <llx@swissonline.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Module Licensing?
Message-ID: <20011108013625.A3316@menzoberrazan.dhis.org>
In-Reply-To: <Pine.LNX.4.33L.0110311535250.2963-100000@imladris.surriel.com> <200110311831.f9VIVeR09294@mail.swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110311831.f9VIVeR09294@mail.swissonline.ch>; from llx@swissonline.ch on Wed, Oct 31, 2001 at 07:31:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Decía LLX:
> > The irrelevance here is IYHO ... it may well be judged that
> > since these two portions of the work need each other in order
> > to function, the thing really is one work.
> 
> a)
> vmware for linux needs a linux kernel to work. does that meen
> you whant to gpl it? 
> 
> b)
> you can write abstraction modules for different os's. and the 
> non-gpl module works with all of them. so my module does not
> need the linux abstraction module it also works with the free-
> BSD module. the only #ifdef in my module will be around the 
> module registration code. or i write a propriatary loader,
> so that even the same binary works for different os's
> 

And you can use a big array with your binary code and made the source public:
/*
  This code is GPL
*/
char *code={big array  of code}



void do_somenthin(){
	void (*fun) = code;
	(*fun)();
}

(well, I dosn't remember the exact sintax of pointer to funtioncs but ... )

You can put the binary driver like "microcode", and GPL


Saludos
Drizzt

-- 
... 10 IF "LAS RANAS"="TIENEN PELO" THEN PRINT "Windows is good".
____________________________________________________________________________
Drizzt Do'Urden              
drizzt.dourden@iname.com     
                             
