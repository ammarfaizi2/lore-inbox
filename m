Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281318AbRKTUM4>; Tue, 20 Nov 2001 15:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281320AbRKTUMh>; Tue, 20 Nov 2001 15:12:37 -0500
Received: from ns.ithnet.com ([217.64.64.10]:58633 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S281318AbRKTUM1>;
	Tue, 20 Nov 2001 15:12:27 -0500
Date: Tue, 20 Nov 2001 21:11:28 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with NAT on 2.4
Message-Id: <20011120211128.1b9ae5fa.skraw@ithnet.com>
In-Reply-To: <20011120195443.6842910619@mcrg>
In-Reply-To: <20011120195443.6842910619@mcrg>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001 20:54:43 +0100
Ricardo Galli <gallir@uib.es> wrote:

> 
>  > Does anybody have an idea why NAT in 2.4.10 wouldn't work like NAT in some
>  > cheap dsl-router equipment regarding http-connections?
>  > Is there any sense in upgrading to 2.4.15-preX?
>  > I even tried some gateway software based on windoze that is able to NAT - 
> and
>  > it works too! I pretty much ran out of ideas...
> 
> Did you disable ECN? (echo 0 > /proc/sys/net/ipv4/tcp_ecn)

Is 0. I didn't explicitely disable, it only happens to be so.

> Did you try a connection to port 80 from the Linux box?

Now this is interesting:

I try a simple telnet www.thedeadman.com 80 (I will post the publicly available
servers name if you want me to) and this is what happens:

not working: (connection fails)
2.0.39, some 2.2.18, 2.4.10, 2.4.13, some 2.2.19

working:
some 2.2.18, some 2.2.19, 2.4.5, 2.4.15-pre3, 2.4.15-pre7

?

Regards,
Stephan

