Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272620AbRIUJMu>; Fri, 21 Sep 2001 05:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272668AbRIUJMk>; Fri, 21 Sep 2001 05:12:40 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:31242 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S272620AbRIUJMg>; Fri, 21 Sep 2001 05:12:36 -0400
Date: Fri, 21 Sep 2001 11:12:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Balazic <david.balazic@uni-mb.si>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Magic SysRq +
Message-ID: <20010921111250.A15010@suse.cz>
In-Reply-To: <3BAB0335.939E59D7@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BAB0335.939E59D7@uni-mb.si>; from david.balazic@uni-mb.si on Fri, Sep 21, 2001 at 11:07:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 11:07:01AM +0200, David Balazic wrote:
> Vojtech Pavlik (vojtech@suse.cz) wrote :
> 
> > On Wed, Sep 19, 2001 at 08:56:13AM -0700, Randy.Dunlap wrote: 
> > > (and maybe earlier...) 
> > > 
> > > Simple problems grow... 
> > > 
> > > Keith Owens has already noted one problem in sysrq.c (2.4.10-pre12). 
> > > 
> > > Beginning: 
> > > 
> > > I have an IBM model KB-9910 keyboard. When I use 
> > > Alt+SysRQ+number (number: 0...9) on it to change the 
> > > console loglevel, only keys 5 and 6 have the desired 
> > > effect. I used showkey -s to view the scancodes from 
> > > the other <number> keys, but showkey didn't display 
> > > anything for them. Any other suggestions? 
> > 
> > Most likely the keyboard scanning matrix doesn't allow that combination. 
> > Quite a large number of keyboards doesn't allow multiple keys pressed 
> > (except for shift, ctrl, alt, which are separate) at once. 
> 
> "we saved 13 cents on keyboard costs !"

Oh yes, you can save some diodes if you don't want all keys pressed at
once ...

> On my Cherry G-83 keyboard ( crap/shit/$"#$"$" !!! ) the alt-SysRq-B
> ( reboot ) combination does not work. I don't know about other combinations.
> 
> Workaround that works for me : press ALT , press SysRq , release ALT , press B

Yes, that's why this workaround was implemented.

-- 
Vojtech Pavlik
SuSE Labs
