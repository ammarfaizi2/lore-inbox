Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264755AbSJOTUN>; Tue, 15 Oct 2002 15:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264761AbSJOTUM>; Tue, 15 Oct 2002 15:20:12 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:50448 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264755AbSJOTUL>;
	Tue, 15 Oct 2002 15:20:11 -0400
Date: Tue, 15 Oct 2002 21:25:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.42 broke ARM zImage/Image
Message-ID: <20021015212554.A4299@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20021015172201.A1406@mars.ravnborg.org> <Pine.LNX.4.44.0210151028270.10165-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210151028270.10165-100000@chaos.physics.uiowa.edu>; from kai-germaschewski@uiowa.edu on Tue, Oct 15, 2002 at 10:30:02AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 10:30:02AM -0500, Kai Germaschewski wrote:
> Actually, we figured out what the problem was now, the link script was 
> given as an argument to ld twice, which obviously confused it. After 
> fixing that, all is well.

Good spot!

Russell - I'm planning to give the makefiles an additional clean-up when they
show up in the linus kernel.
There is still a few bits here and there that could use some attention, and
when Linus pull the next bunch of updates from Kai the handling of clean
has been improved. I'm planning to introduce this in arm too - just
to finish the job in a proper way.

OK?

If you want me to do it beforehand then just give me a pointer to a tree
where I can pull from.

And I'm glad the two of you got it solved, now I just fear what problems
shows up for the next architecture...

	Sam
