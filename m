Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269158AbRIDPAL>; Tue, 4 Sep 2001 11:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269756AbRIDO7w>; Tue, 4 Sep 2001 10:59:52 -0400
Received: from [216.151.155.121] ([216.151.155.121]:59402 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S269158AbRIDO7n>; Tue, 4 Sep 2001 10:59:43 -0400
To: jlmales@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question Re AC Patch with VM Tuneable Parms for now
In-Reply-To: <3B943CB0.14656.754C73@localhost>
From: Doug McNaught <doug@wireboard.com>
Date: 04 Sep 2001 10:59:55 -0400
In-Reply-To: "John L. Males"'s message of "Tue, 4 Sep 2001 02:30:08 -0500"
Message-ID: <m37kvfovbo.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John L. Males" <jlmales@softhome.net> writes:

> Can someone advise me if the "Make several vm behaviours tunable for
> now" as of the 2.4.9-ac4 patch are implemented in the kernel .config
> file?  If so is there an easy way to carry forward a 2.4.8 version of
> the .config file using "make xconfig" so that I do not have to set
> all the setting I have made from scratch?  I get the sense from the
> Kernel documentation that one can run a process that will ask one
> only those parameters that have been changed or added rather that all
> of them, but best I can tell this is a console y/n/?? type response.

You have to do the carry-forward on the command line, using 
'make oldconfig'.  It will prompt you to answer any questions that
aren't in the old config file, which will usually be fairly few.  So
it's not that bad, and you only have to do it once per upgrade.

Once you've done it, you can use 'menuconfig' as usual to tune your
configuration.  

BTW, it's quite likely (though I haven't looked at it) that the
VM tunables are in /proc rather than being config options.

-Doug
-- 
Free Dmitry Sklyarov! 
http://www.freesklyarov.org/ 

We will return to our regularly scheduled signature shortly.
