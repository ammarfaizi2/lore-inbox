Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318866AbSHWQCj>; Fri, 23 Aug 2002 12:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318869AbSHWQCj>; Fri, 23 Aug 2002 12:02:39 -0400
Received: from relay1.pair.com ([209.68.1.20]:17933 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S318866AbSHWQCi>;
	Fri, 23 Aug 2002 12:02:38 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3D665EC9.3EF93C37@kegel.com>
Date: Fri, 23 Aug 2002 09:11:53 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Gardiner Myers <jgmyers@netscape.com>
CC: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 
 (Re:async-io API registration for 2.5.29)]
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk>
	 <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com>
	 <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random>
	 <20020815214225.H29874@redhat.com> <20020816150945.A1832@in.ibm.com>
	 <3D5D0186.7B7724BC@kegel.com> <3D5D1D02.7080206@netscape.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Gardiner Myers wrote:
> 
> Dan Kegel wrote:
> 
> >You can actually consider posix AIO using sigtimedwait() to pick up completion
> >notices to fit the definition of completion port if you squint a bit.
> >
> Except that signal queues are far too short to be useful for c10k.  It's
> also not possible to allocate a queue (signal number) in a thread safe
> manner.
> 
> Posix AIO is a horrid interface.  Ben has done much better.

You're quite right.  Still, posix AIO with sigtimedwait() might be enough
prior art to invalidate Microsoft's patent on completion ports.

- Dan
