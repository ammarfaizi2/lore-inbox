Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262632AbTCZXim>; Wed, 26 Mar 2003 18:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262641AbTCZXim>; Wed, 26 Mar 2003 18:38:42 -0500
Received: from [66.186.193.1] ([66.186.193.1]:18186 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id <S262632AbTCZXil>; Wed, 26 Mar 2003 18:38:41 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 63.109.146.2
X-Authenticated-Timestamp: 18:52:51(EST) on March 26, 2003
X-HELO-From: [10.134.0.78]
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 63.109.146.2
Subject: Re: [REPRODUCABLE BUGS] Linux 2.5.66
From: Torrey Hoffman <thoffman@arnor.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Toplica Tanaskovic <toptan@EUnet.yu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303262024270.21188-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0303262024270.21188-100000@phoenix.infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048722582.2039.11.camel@rohan.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Mar 2003 15:49:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a similar bug on my sis framebuffer, using 2.5.66 and the
latest patch you sent to the kernel mailing list Wednesday morning with
the subject "Framebuffer fixes."   That was about half an hour before
the message where you said you had fixed this in bk, so maybe the patch
didn't have the fix?  

Anyway the bug I see is:  If I use fbset to change between 1024x768,
800x600, and 640x480 the console doesn't seem to be aware of the
change.  However, it doesn't seem to cause corruption or oops'es, at
least for me so far.

However, I am pleased to say that I am able to use the sis framebuffer
driver now.  Last time I tried, around 2.5.64 I think, I got serious
screen corruption switching between X and the framebuffer console.

So things are getting better... thanks for all your work!

Torrey Hoffman
 
On Wed, 2003-03-26 at 12:24, James Simmons wrote:
> > > For console resizing try using stty cols xxx rows xx.
> > >
> > 	Tried.  Not working again. Last line of the text is at same position like 
> > when changing mode with fbset, upper lines are now on the right where garbage 
> > is when using fbset.
> > 	First scrolling gives an oops, but due to screen corruption I could not write 
> > down message displayed. Nothing in logs due to irregular reboot.
> 
> I seen this bug. I fixed it in BK.

-- 
Torrey Hoffman <thoffman@arnor.net>

