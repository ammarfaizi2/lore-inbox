Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbTAYRbf>; Sat, 25 Jan 2003 12:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbTAYRbf>; Sat, 25 Jan 2003 12:31:35 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:46538 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261581AbTAYRbf>;
	Sat, 25 Jan 2003 12:31:35 -0500
Date: Sat, 25 Jan 2003 18:40:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Bradford <john@grabjohn.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [Corrected] Set2 scancodes for Japanese keyboard
Message-ID: <20030125184046.A16824@ucw.cz>
References: <20030125183001.F16711@ucw.cz> <200301251737.h0PHbcZY001157@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200301251737.h0PHbcZY001157@darkstar.example.net>; from john@grabjohn.com on Sat, Jan 25, 2003 at 05:37:38PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 05:37:38PM +0000, John Bradford wrote:
> > 
> > On Sat, Jan 25, 2003 at 05:28:25PM +0000, John Bradford wrote:
> > 
> > > Some got missed off the first time:
> > 
> > What kernel this is tested with? What method used? These don't look like
> > Set2 codes AT ALL.
> 
> The kernel is 2.4.20.  The keycode is the output from showkey, and the
> make and break codes are the output from showkey -s.
> 
> Should I have used I8042_DEBUG_IO instead?  :-/

With 2.5, yes, that'd be much better. And yet better it'd be if you'd
have used the "i8042_direct=1" kernel option, and for set3 the
"atkbd_set=3" option.

I'm sorry to tell you after you wrote it all down, but these are set1
scancodes you see.

-- 
Vojtech Pavlik
SuSE Labs
