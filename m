Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVGCTnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVGCTnq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 15:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVGCTmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 15:42:47 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:4366 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261508AbVGCTmR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 15:42:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fWI3h5n30TtLMOuYUj/iXeiK76nBo6hVkgICMq7h0D+TW8/9U41gBTLQNcZIw/eqekn8x1ZydmeN4WyM2M591wjbQDnznRZMvgbL+iObq6hdb4MYzQruVpJvgdpiYQ4MDo42Hn/G1nBIyaACj31OEgEl/7N17I6rw3CUwYKg6zM=
Message-ID: <9a8748490507031242270cc89@mail.gmail.com>
Date: Sun, 3 Jul 2005 21:42:17 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>
Subject: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       Yani Ioannou <yani.ioannou@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <1120418514.4351.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1119559367.20628.5.camel@mindpipe>
	 <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>
	 <20050625144736.GB7496@atrey.karlin.mff.cuni.cz>
	 <42BD9EBD.8040203@linuxwireless.org> <20050625200953.GA1591@ucw.cz>
	 <42C7A3B2.4090502@linuxwireless.org> <20050703101613.GA2372@ucw.cz>
	 <9a8748490507030407547fa29b@mail.gmail.com>
	 <42C82BBB.9090008@gmail.com> <1120418514.4351.6.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/05, Dave Hansen <dave@sr71.net> wrote:
> On Sun, 2005-07-03 at 20:17 +0200, Jesper Juhl wrote:
> > Ok, just to show you people what I've done so far.
> > This doesn't work yet, but it should be resonably close (at least it
> > builds ;)
> 
> On top of what you sent at first this morning (not the most recent one)

I believe you are refering to the driver Henrik Brix Andersen wrote.
It seems we both started implementing the same thing at aproximately
the same time. I only saw Henriks version after I had send in my own.
His seems to work a bit better than mine :-)


Henrik: Are you planning on doing more work on this?   I ask since it
seems we are duplicating effort atm.  I think we should instead pool
our resources and work on just one implementation (don't know if
you've seen mine, but it's in the lkml archives earlier in this
thread).
What are your plans? Got any suggestions on how we should proceed? 
Personally I just want to end up with a working driver and I don't
care much if we use your work or mine as a starting point.

 
> I did some stuff (in the attached patch).  It implements the last bit of
> initialization that your earlier one didn't do, but I see you've done in
> the most recent one.
> 
Again, you did something on top of Henriks driver, but it is fairly
close to what I myself did.

> Anyway, I get 10 reads out of it, 1 second apart, and it appears to be
> getting real data:
> 

Great, nice to see that something seems to be working. :-)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
