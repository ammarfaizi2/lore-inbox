Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279969AbRKVQXL>; Thu, 22 Nov 2001 11:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279984AbRKVQW7>; Thu, 22 Nov 2001 11:22:59 -0500
Received: from ns.ithnet.com ([217.64.64.10]:5896 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S279969AbRKVQWo>;
	Thu, 22 Nov 2001 11:22:44 -0500
Date: Thu, 22 Nov 2001 17:22:35 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Swap vs No Swap.
Message-Id: <20011122172235.4ef9e54a.skraw@ithnet.com>
In-Reply-To: <F128989C2E99D4119C110002A507409801C52F89@topper.hrow.ndsuk.com>
In-Reply-To: <F128989C2E99D4119C110002A507409801C52F89@topper.hrow.ndsuk.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001 16:11:29 -0000
"Elgar, Jeremy" <JElgar@ndsuk.com> wrote:

> Hum think I'm going to test this idea out tonight, quick question without
> swap at what point would the kernel stop giving memory up for cache
> purposes. For example I noticed on Tuesday whist doing a back up of a file
> system (in-line tar cd untar) I was left with ~4 Mb left having nearly the
> rest of my 2Gb Ram used for cache.
> 
> Would this ram be given back to the free pool much more readily? 

Not to my knowledge. Since I was pretty much bitten by swap in former days I
plugged in more RAM and stopped swap completely. I must admit that it didn't
get any faster, but trashing is gone (obviously). But this is only because of
my own dumbness placing swap on the same drive as root-fs. I guess it would be
a good idea to use the former small hds (1-2 GB) for swap completely, so any
bad interaction with normal fs is omitted.
BTW maybe you should try the latest preX versions, they tend to have more
_free_ mem available and perform pretty ok on my system.

Regards,
Stephan
