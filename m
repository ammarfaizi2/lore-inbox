Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272465AbRIUJHA>; Fri, 21 Sep 2001 05:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272737AbRIUJGv>; Fri, 21 Sep 2001 05:06:51 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:30981 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S272465AbRIUJGp>;
	Fri, 21 Sep 2001 05:06:45 -0400
Date: Fri, 21 Sep 2001 11:07:01 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Magic SysRq +
To: vojtech@suse.cz
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3BAB0335.939E59D7@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik (vojtech@suse.cz) wrote :

> On Wed, Sep 19, 2001 at 08:56:13AM -0700, Randy.Dunlap wrote: 
> > (and maybe earlier...) 
> > 
> > Simple problems grow... 
> > 
> > Keith Owens has already noted one problem in sysrq.c (2.4.10-pre12). 
> > 
> > Beginning: 
> > 
> > I have an IBM model KB-9910 keyboard. When I use 
> > Alt+SysRQ+number (number: 0...9) on it to change the 
> > console loglevel, only keys 5 and 6 have the desired 
> > effect. I used showkey -s to view the scancodes from 
> > the other <number> keys, but showkey didn't display 
> > anything for them. Any other suggestions? 
> 
> Most likely the keyboard scanning matrix doesn't allow that combination. 
> Quite a large number of keyboards doesn't allow multiple keys pressed 
> (except for shift, ctrl, alt, which are separate) at once. 

"we saved 13 cents on keyboard costs !"

On my Cherry G-83 keyboard ( crap/shit/$"#$"$" !!! ) the alt-SysRq-B
( reboot ) combination does not work. I don't know about other combinations.

Workaround that works for me : press ALT , press SysRq , release ALT , press B


-- 
David Balazic
--------------
"Be excellent to each other." - Bill S. Preston, Esq., & "Ted" Theodore Logan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
