Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268228AbUH2R3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbUH2R3e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268234AbUH2R3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:29:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:40367 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268228AbUH2R2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:28:34 -0400
Date: Sun, 29 Aug 2004 10:17:18 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: nemosoft@smcc.demon.nl, torvalds@osdl.org, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org, pmarques@grupopie.com, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: pwc+pwcx is not illegal
Message-Id: <20040829101718.00cd791e.rddunlap@osdl.org>
In-Reply-To: <1093794141.28139.5.camel@localhost.localdomain>
References: <1093634283.431.6370.camel@cube>
	<Pine.LNX.4.58.0408271226400.14196@ppc970.osdl.org>
	<1093788018.27901.35.camel@localhost.localdomain>
	<200408291833.37808@smcc.demon.nl>
	<1093794141.28139.5.camel@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 16:42:24 +0100 Alan Cox wrote:

| On Sul, 2004-08-29 at 17:33, Nemosoft Unv. wrote:
| > That's one of the reasons I requested PWC to be removed. For me, it's also a 
| > matter of quality: what good is a half-baked driver in the kernel when you 
| > need to patch it first to get it working fully again? I don't want my name 
| > attached to that.
| 
| It works very well for some users without that code. The raw pass
| through for the compressed bitstreams solved the problems for the rest.
| You appear to be seeking to hurt your userbase for your own ends. Thats
| not pleasant behaviour.  I can more than understand
| "take my name off it, make it clear its nothing to do with me".
| 
| > > Its also trivial to move the decompressor to user space 
| > > where it should be anyway. 
| > 
| > *sigh* As I have been saying a 100 times before, it is illogical, cumbersome 
| > for both users and developers, and will probably take a very long time to 
| > adopt (notwithstanding V4L2 [*]). 
| 
| Video4linux has -always- specified decompressors in user space. This was
| pointed out ages ago. V4L2 rationalised it even more clearly.
| 
| > *IF* there was a commonly accepted video "middle-layer", this would not pose 
| > much of a problem. But there is no such thing yet.
| > 
| > (maybe that's something for a 2.7 kernel...)
| 
| No its for userspace. Just add it to the relevant video frameworks.
| 
| > Seriously, this probably would not have happened if, back in 2001, the 
| > driver was rejected on the basis of this hook (you were there, Alan...) I 
| > never made a secret of it, it has been in the driver from day 1 and its 
| > purpose was clearly spelled out. If it had been rejected, I would probably 
| > have just switched to '3rd party module' mode and maintained it outside the 
| > kernel indefinetely. I would not have liked it, but it would have been 
| > acceptable.
| 
| Back in 2001 I was saying that this was broken and it belonged in user
| space.

Yes, that's right, and it should be done by now...
We kept expecting updates in that direction.

| > of thing in the kernel. However, since we're a bit late to react, we'll 
| > leave it in the 2.4 and 2.6 series, but versions beyond that (2.7-devel, 
| > etc) will not have PWC included in this form. In the mean time, we're 
| > asking you to think of a solution". Chances are the situation would have 
| > been fully resolved before that (and I mean fully *hint*).
| 
| There isn't a plan to have a 2.7 development tree but to do gradual
| development until something major comes up. That makes the suggestion
| rather more tricky - as does the legal question.


--
~Randy
