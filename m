Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSIPVw1>; Mon, 16 Sep 2002 17:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbSIPVw1>; Mon, 16 Sep 2002 17:52:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:9229 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263143AbSIPVw1>;
	Mon, 16 Sep 2002 17:52:27 -0400
Message-Id: <200209162157.g8GLvPO21115@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: cliffw@osdl.org
Subject: Re: contest v0.30 
In-Reply-To: Message from Con Kolivas <conman@kolivas.net> 
   of "Tue, 17 Sep 2002 00:46:03 +1000." <1032187563.3d85eeabbdf77@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Sep 2002 14:57:25 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> I've updated the "contest" responsiveness benchmark with many code cleanups by
> Rik Van Riel, and a more comprehensive readme. The actual benchmarks have not
> changed from v0.22 onwards. Previous versions were all slightly different
> because of bugs in the code. You can compare like with like from now on. Please
> don't use this to compare different hardware; it is unhelpful and the results
> will only confuse. Use it to compare kernels on the same hardware. I guess it
> could be used to compare filesystems (eg ext3 v reiser) with respect to the
> system maintaining responsiveness, but noone's attempted that yet. If anyone's
> got any other novel uses I'd love to hear them.
> 
> It now has a homepage:
> http://contest.kolivas.net
> 
> Please feel free to send me any comments, questions, suggestions
> Con Kolivas
> -

It looks neat, and i'd like to add it to the STP tests. 
I noticed you have hardcoded the '-j 4' 
Wouldn't it make more sense to adjust that to say, number_of_cpus * 2
or something?
cliffw


> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


