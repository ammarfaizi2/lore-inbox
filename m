Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263205AbSJCInh>; Thu, 3 Oct 2002 04:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263207AbSJCInh>; Thu, 3 Oct 2002 04:43:37 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:64210 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263205AbSJCInf>;
	Thu, 3 Oct 2002 04:43:35 -0400
Date: Thu, 3 Oct 2002 10:48:40 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jbradford@dial.pipex.com
Cc: Tobias Ringstrom <tori@ringstrom.mine.nu>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: AT keyboard input problem
Message-ID: <20021003104840.B37411@ucw.cz>
References: <Pine.LNX.4.44.0210030846180.11746-100000@boris.prodako.se> <200210030836.g938a54o001105@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210030836.g938a54o001105@darkstar.example.net>; from jbradford@dial.pipex.com on Thu, Oct 03, 2002 at 09:36:05AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 09:36:05AM +0100, jbradford@dial.pipex.com wrote:
> > While 2.5 has worked better than I hoped for so far, I do have a problem 
> > with the new input layer (I think) that is easily reproducible, and quite 
> > irritating.
> > 
> > If I press and hold my left Alt key, press and release the right AltGr
> > key, and then release the left Alt key, I get one of the following
> > messages in dmesg:
> 
> [snip]
> 
> > The same thing happens for a few other combinations as well. I happens 
> > both in X and in the console.
> 
> I am getting similar odd behavior with 2.5.40 and a Japanese keyboard.  Specifically, if I bang away at repeatedly on 't', 'h', '@', and ';', I get unknown key messages in dmesg.
> 
> I posted about this a while ago, but I don't think anybody noticed :-)

Can you #define I8042_DEBUG_IO in i8042.h and send me the 'dmesg' output
of the unknown key message and data around it?

-- 
Vojtech Pavlik
SuSE Labs
