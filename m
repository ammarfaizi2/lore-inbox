Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288606AbSATOU6>; Sun, 20 Jan 2002 09:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288614AbSATOUt>; Sun, 20 Jan 2002 09:20:49 -0500
Received: from ns.ithnet.com ([217.64.64.10]:44294 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288606AbSATOUg>;
	Sun, 20 Jan 2002 09:20:36 -0500
Date: Sun, 20 Jan 2002 15:20:31 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Would anyone be willing to host a second kernel.org site?
Message-Id: <20020120152031.2f39201c.skraw@ithnet.com>
In-Reply-To: <a2d46c$9c2$1@cesium.transmeta.com>
In-Reply-To: <a2d46c$9c2$1@cesium.transmeta.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jan 2002 16:49:16 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> The recent troubles we've had at kernel.org pretty much highlight the
> issues with having an offsite system with no easy physical access.
> This begs the question if we could establish another primary
> kernel.org site; this would not only reduce the load on any one site
> but deal with any one failure in a much more graceful way.
> 
> Anyone have any ideas of some organization who would be willing to
> host a second kernel.org server?  Such an organization should expect
> around 25 Mbit/s sustained traffic, and up to 40-100 Mbit/s peak
> traffic (this one can be adjusted to fit the available resources.)
> 
> If so, please contact me...

Hello Peter,

I don't know if this could be any real help, but anyway I have a slightly
different suggestion, that may be interesting. Years ago we did a DNS-project
that allows to spread a domain to several _different_ ip locations based on the
dns-_requesting_ ip. You may know such a technique from akamai (MS daughter).
In fact we implemented and test-runned it years ago, but did not find any
customer interested (in fact only real big customers _can_ be interested at
all, and we didn't have the "connections"). Anyway the know-how is still here
and can be used to help kernel.org, if interested. The basic idea is, that this
splits costs in running kernel.org to several locations. These locations can
(e.g.) be providers who may have some strategic interests. You may as well come
up with a GNU project of spreading kernel.org mirrors - meaning every provider
be it small or big can have its own mirror, and _only_ his customers (depending
on their IP or his AS) are using it. So if you have a major breakdown at the
primary server, people will get no _new_ pages, but kernel.org itself looks up
throughout all IP-ranges that have a mirror "attached".

What do you think?

Regards,
Stephan von Krawczynski

