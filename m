Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310434AbSCURPq>; Thu, 21 Mar 2002 12:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312394AbSCURPh>; Thu, 21 Mar 2002 12:15:37 -0500
Received: from ns.ithnet.com ([217.64.64.10]:53765 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S310434AbSCURP1>;
	Thu, 21 Mar 2002 12:15:27 -0500
Date: Thu, 21 Mar 2002 18:15:16 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: sneakums@zork.net, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020321181516.24ea3fbd.skraw@ithnet.com>
In-Reply-To: <20020321180750.A2706@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002 18:07:50 +0300
Oleg Drokin <green@namesys.com> wrote:

> > Maybe my mkreiserfs util is old, and I should try recreating the volumes
> > with a newer version? Were there "suspicious" changes during 3.6 format?
> 
> Not any I am aware of.

Hello Oleg,

I just re-created the questionable fs (both) with a freshly compiled
util-package (reiserfsprogs-3.x.1b) and now things are even more weird:

It now works, depending on which fs I mount first. Remeber both are completely
new 3.6 fs. I can really reproduce mounting "a", then "b" works, but first
mounting "b", then "a" has the problem. Did you try something like this (play
with the mounting sequence)?

Regards,
Stephan

