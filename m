Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293354AbSBYIyB>; Mon, 25 Feb 2002 03:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293350AbSBYIxw>; Mon, 25 Feb 2002 03:53:52 -0500
Received: from marge.bucknell.edu ([134.82.9.1]:42245 "EHLO mail.bucknell.edu")
	by vger.kernel.org with ESMTP id <S293349AbSBYIxp>;
	Mon, 25 Feb 2002 03:53:45 -0500
Subject: Re: Equal cost multipath crash
From: Eric Krout <ekrout@bucknell.edu>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <20020225083911.GA18777@informatics.muni.cz>
In-Reply-To: <20020225083911.GA18777@informatics.muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 25 Feb 2002 03:53:52 -0500
Message-Id: <1014627232.2332.6.camel@ekrout.resnet.bucknell.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-25 at 03:39, Jan Kasprzak wrote:
> 	Hello network hackers,
> 
> 	I had a strange failure of my Linux router yesterday. 
	...
> Feb 24 21:26:49 router kernel: impossible 888
> Feb 24 21:39:20 router kernel: ible 888
> Feb 24 21:39:20 router kernel: impossible 888
> Feb 24 21:39:20 router last message repeated 42 times
> Feb 24 21:39:20 router kernel: impossible 888
> Feb 24 21:39:21 router kernel: NET: 344 messages suppressed.
> Feb 24 21:39:21 router kernel: dst cache overflow
> Feb 24 21:39:21 router kernel: impossible 888
> Feb 24 21:39:21 router last message repeated 275 times
> [... and so on ...]
> 
> 	After few minutes, a co-worker of mine pressed the big red button.
> 
	...


Most code I've seen that prints "impossible" looks like this:


/* This is a disaster if it occurs */
printk("impossible");


I'd say it's a Good Thing(tm) that your co-worker "pressed the big red
button"  ;-)

(Sorry, that's the best I could come up with at 3:51am)

