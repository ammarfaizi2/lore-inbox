Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261331AbTCTIqK>; Thu, 20 Mar 2003 03:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261332AbTCTIqJ>; Thu, 20 Mar 2003 03:46:09 -0500
Received: from zork.zork.net ([66.92.188.166]:8424 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S261331AbTCTIqJ>;
	Thu, 20 Mar 2003 03:46:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Everything gone!
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: HATE SPEECH, HYPERLINK PATENT
 INFRINGEMENT
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 20 Mar 2003 08:57:08 +0000
In-Reply-To: <Pine.LNX.4.53.0303191158180.31905@chaos> ("Richard B.
 Johnson"'s message of "Wed, 19 Mar 2003 12:01:37 -0500 (EST)")
Message-ID: <6uisuefmaj.fsf@zork.zork.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <Pine.LNX.4.53.0303191041370.27397@quark.analogic.com>
	<20030319160437.GA22939@citd.de>
	<1048091858.989.10.camel@bip.localdomain.fake>
	<Pine.LNX.4.53.0303191158180.31905@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Richard B. Johnson quotation:

> I think that, with a single instance of `rm`, not as written above,
> this would complete because all the open runtime libraries would
> remain mem-mapped until the last close. So, I think you could
> remove everything with -rf except the programs that will return
> 'text file busy' errors because they are open for execution.

Linux allows files that are being executing to be unlinked.  You will
get ETXTBUSY if you open the file and try to modify it, though.

-- 
Sean Neakums - <sneakums@zork.net>
