Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319234AbSHNBOs>; Tue, 13 Aug 2002 21:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319236AbSHNBOs>; Tue, 13 Aug 2002 21:14:48 -0400
Received: from zok.SGI.COM ([204.94.215.101]:40664 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S319234AbSHNBOs>;
	Tue, 13 Aug 2002 21:14:48 -0400
Message-ID: <3D59B022.BA63F063@alphalink.com.au>
Date: Wed, 14 Aug 2002 11:19:30 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
CC: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208131306040.6035-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> 
> > > So you agree a bit of spring cleaning wouldn't hurt, right? ;)
> >
> > Absolutely, and I have a catalogue of dust puppies to help that process ;-)
> 
> Okay. Let me first state that I do not really have the time to get
> involved currently. ISDN4Linux and other pending kbuild stuff already
> takes somewhat more than the remaining free time I have. But if you guys
> want to get going with some step by step cleaning (w/o breaking too much),
> I can try to help reviewing and submitting to Linus.

Great.

> Basically, extend the "source" command to do a grep CONFIG_* in the file
> to be read and set all found symbols to "n", if unset - only then do
> the actual "source".

Ah, interesting idea.

> Anyway, some more points:
> 
> o a) dep_bool '  Blah' CONFIG_FOO $CONFIG_BAR         vs.
>   b) dep_bool '  Blah' CONFIG_FOO CONFIG_BAR

I assume you include in a) the change which gives all symbols an "n" default.
Then b) is clearly the evolutionary approach and less likely to result in a
partially broken config system come Halloween.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
