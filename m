Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUHaF5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUHaF5B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 01:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUHaF5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 01:57:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5251 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266663AbUHaF47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 01:56:59 -0400
Message-ID: <4134131D.6050001@pobox.com>
Date: Tue, 31 Aug 2004 01:56:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Linus Torvalds <torvalds@osdl.org>, Tom Vier <tmv@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Userspace file systems & MKs (Re: silent semantic changes with
 reiser4)
References: <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org> <20040831033950.GA32404@zero> <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org> <413400B6.6040807@pobox.com> <20040831053055.GA8654@nietzsche.lynx.com>
In-Reply-To: <20040831053055.GA8654@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> DragonFly BSD, the only remotely functional open source BSD project on this
> planet, has plans in place to push certain kernel components like their VFS
> layer into userspace for easier debugging, testing and other things that go

That violates Jeff's First Rule, put the fast path stuff in the kernel.


> with developing file systems easily. If they back it with something like C++
> for doing constructor style type conversion on top of overloaded operators
> to back VFS data structure translation, could easily import stuff like most
> Linux file systems without major restructuring, say, if they had their
> translation library written. In this case, userspace kernel systems have
> some serious programming advantages over traditional kernels.

Sounds like security would be a pain in the ass :)


> They're also pushing an async syscall model to support a non-1:1 threading
> system for userspace unlike what Linux has done with futexes. It'll allow

messaging passing is also known as "really slow C function calls"

My PCI bus passes messages all the time.  A message is in the eye of the 
beholder.

	Jeff


