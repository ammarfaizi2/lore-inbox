Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318516AbSHPOTf>; Fri, 16 Aug 2002 10:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318518AbSHPOTf>; Fri, 16 Aug 2002 10:19:35 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:226 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318516AbSHPOTf>; Fri, 16 Aug 2002 10:19:35 -0400
Date: Fri, 16 Aug 2002 15:21:33 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Dan Kegel <dank@kegel.com>
Cc: suparna@in.ibm.com, Benjamin LaHaise <bcrl@redhat.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020816152133.B590@kushida.apsleyroad.org>
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random> <20020815214225.H29874@redhat.com> <20020816150945.A1832@in.ibm.com> <3D5D0186.7B7724BC@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D5D0186.7B7724BC@kegel.com>; from dank@kegel.com on Fri, Aug 16, 2002 at 06:43:34AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> You can actually consider posix AIO using sigtimedwait() to pick up
> completion notices to fit the definition of completion port if you
> squint a bit.

... with the bonus that it fits comfortably into a sigtimedwait() loop
that's waiting for non-AIO things too.

-- Jamie
