Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312350AbSCUPF7>; Thu, 21 Mar 2002 10:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312348AbSCUPFt>; Thu, 21 Mar 2002 10:05:49 -0500
Received: from ns.ithnet.com ([217.64.64.10]:8715 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S312350AbSCUPFi>;
	Thu, 21 Mar 2002 10:05:38 -0500
Date: Thu, 21 Mar 2002 16:05:26 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: sneakums@zork.net, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020321160526.727b0f31.skraw@ithnet.com>
In-Reply-To: <20020321180117.A2638@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002 18:01:17 +0300
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Thu, Mar 21, 2002 at 03:57:31PM +0100, Stephan von Krawczynski wrote:
> 
> > 2) the problem _is_ dependant on the fs mounted in the following form:
> > mounting two fs that are located on the _same_ reiserfs _works_.
> > mounting two fs that are located on _different_ reiserfs _does not work_.
> > How about that?
> 
> I cannot reproduce it locally, that's it.
> And if you have reiserfs v3.6 (that's it, not v3.5 converted to 3.6,
> but v3.6 created with mkreiserfs), then I am out of ideas for you :(

I never did any conversion. I just don't trust it.
Maybe my mkreiserfs util is old, and I should try recreating the volumes with a
newer version? Were there "suspicious" changes during 3.6 format?

Regards,
Stephan

