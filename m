Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292356AbSBBTXD>; Sat, 2 Feb 2002 14:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292361AbSBBTW5>; Sat, 2 Feb 2002 14:22:57 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:20873 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S292356AbSBBTWN>; Sat, 2 Feb 2002 14:22:13 -0500
Date: Sat, 2 Feb 2002 19:22:13 +0000
From: Anthony Campbell <ac@acampbell.org.uk>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Total lockups using ext3
Message-ID: <20020202192213.GB3827@debian.local>
In-Reply-To: <20020201181048.GA3104@debian.local> <20020201184123.A16610@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020201184123.A16610@redhat.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Feb 2002, Stephen C. Tweedie wrote:
> Hi,
> 
> On Fri, Feb 01, 2002 at 06:10:48PM +0000, Anthony Campbell wrote:
>  
> > They always occur when I am online, downloading. The moden stops, the
> > hard disk light is on, and no key works. They never happen with 2.2.20
> > or with earlier (i.e. pre-ext3) 2.4 kernels, and they never occur on my
> > laptop with any kernel, including those using ext3.
> > 
> > Since inactivating ext3 (by changing /etc/fstab) the lockups have ceased
> > to occur.
> > 
> > I therefore conclude that the lockups are due to ext3. I can manage
> > without it but would like to use it if possible. Any suggestions please?
> 
> Doesn't sound like a filesystem problem --- if the hd remains on, it
> sounds very much as if you've got something going wrong in the disk
> stack, either in the ide driver or the disk itself giving up.  The
> fact that it always happens when the modem is on also suggests that
> this is not a filesystem problem.
> 

> Try reproducing it with a readable console enabled --- either run in
> text console mode (no X), or set up a serial console and use another
> machine to capture the output.  "ttywatch" is excellent for monitoring
> serial consoles.
> 
> Cheers,
>  Stephen
> 

I doubt it's the disk; it works perfectly without ext3, even downloading
a complete kernel tarball. I'll try the text console later (though
probably at the cost of yet another reboot...)

Anthony

-- 
Anthony Campbell - running Linux GNU/Debian (Windows-free zone)
For an electronic book (The Assassins of Alamut), skeptical 
essays, and over 150 book reviews, go to: http://www.acampbell.org.uk/

Our planet is a lonely speck in the great enveloping cosmic dark. In our
obscurity, in all this vastness, there is no hint that help will come
from elsewhere to save us from ourselves. [Carl Sagan]



