Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272703AbRISUWp>; Wed, 19 Sep 2001 16:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274163AbRISUW0>; Wed, 19 Sep 2001 16:22:26 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:10249 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S272703AbRISUWY>; Wed, 19 Sep 2001 16:22:24 -0400
Date: Wed, 19 Sep 2001 22:22:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Randy.Dunlap" <rddunlap@osdlab.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, crutcher+kernel@datastacks.com,
        lkml <linux-kernel@vger.kernel.org>, paulus@au.ibm.com
Subject: Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
Message-ID: <20010919222242.A3775@suse.cz>
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org>; from rddunlap@osdlab.org on Wed, Sep 19, 2001 at 08:56:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 08:56:13AM -0700, Randy.Dunlap wrote:
> (and maybe earlier...)
> 
> Simple problems grow...
> 
> Keith Owens has already noted one problem in sysrq.c (2.4.10-pre12).
> 
> Beginning:
> 
> I have an IBM model KB-9910 keyboard.  When I use
> Alt+SysRQ+number (number: 0...9) on it to change the
> console loglevel, only keys 5 and 6 have the desired
> effect.  I used showkey -s to view the scancodes from
> the other <number> keys, but showkey didn't display
> anything for them.  Any other suggestions?

Most likely the keyboard scanning matrix doesn't allow that combination.
Quite a large number of keyboards doesn't allow multiple keys pressed
(except for shift, ctrl, alt, which are separate) at once.

-- 
Vojtech Pavlik
SuSE Labs
