Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSH0WoG>; Tue, 27 Aug 2002 18:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSH0WoG>; Tue, 27 Aug 2002 18:44:06 -0400
Received: from air-2.osdl.org ([65.172.181.6]:14091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S315762AbSH0WoE>;
	Tue, 27 Aug 2002 18:44:04 -0400
Message-Id: <200208272248.g7RMmIO14827@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
cc: conman@kolivas.net, linux-kernel@vger.kernel.org, cliffw@osdl.org
Subject: Re: Combined performance patches update for 2.4.19 
In-Reply-To: Message from "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org> 
   of "Sun, 25 Aug 2002 02:58:38 +0800." <20020824185838.2961.qmail@linuxmail.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Aug 2002 15:48:18 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: conman@kolivas.net
> Date: Sat, 24 Aug 2002 22:21:37 +1000
> 
> > > > > BTW, thank you for your great work!!
> > > > 
> > > > My pleasure, but really the hard work is done by the developers!
> > > Sure, but your "performance" approach is really intersting! Do you use a
> > > benchmark?
> > 
> > I don't really have the time to benchmark these things any more than "it feels
> > faster". Really I'm spending way too much time on this as it is and I'm not
> > remotely any authority on what benchmarks to use.
> Maybe I can find the time to run a few tests, can anyone suggest me an "intersting" test?

Not to toot our own horn too much, but..
We keep all the interestings tests we can find at: http://www.osdl.org/stp.
The big list is at: http://www.osdl.org/cgi-bin/eidetic.cgi?command=display&mod
ulename=tests
Plus you can become an associate, and get some time on hardware!
cliffw
> 
>  
> > > > > I'm also testing the compressed cache (the 
> > > > > patch you've discarded, and I got good performance!)
> > > > 
> > > > I'm thinking of eventually merging the latest version of this into 2.4.19
> > > too
> > > > since it can be enabled or disabled. Depends on the demand.
> > > Just an hint ('cause I made some of the test you can see on the compressed
> > > cache web page on sourceforge),
> > > if you use that patch boot your box with the 
> > > compressed=XXM in order to set the amount of the compressed cache. My box
> > > runs fast and happy with 32MiB or 64MiB of compressed cache. My box has
> > > 256MiB of Ram.
> > 
> > Ok thanks for the info. I believe the newer cc patch (not in my 2.4.18-ck4) is
> > better anyway. I'm afraid the cc will be later in the piece assuming I can kill
> > off the other bug I've created in the merge. I'd prefer to see a cc patch
> > specifically for 2.4.19 as forward porting it to .19 and then to O(1) (and so
> > on) are just too many steps. 
> Fair enough.
> I think that soon we'll see the cc path for the 2.4.19, Rodrigo?
> 
> Ciao,
>           Paolo
> -- 
> Get your free email from www.linuxmail.org 
> 
> 
> Powered by Outblaze
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


