Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbSIXVVw>; Tue, 24 Sep 2002 17:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261797AbSIXVVw>; Tue, 24 Sep 2002 17:21:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40208 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261800AbSIXVVv>;
	Tue, 24 Sep 2002 17:21:51 -0400
Message-ID: <3D90D889.2040608@pobox.com>
Date: Tue, 24 Sep 2002 17:26:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry Kessler <kessler@us.ibm.com>
CC: Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [evlog-dev] Re: alternate event logging proposal
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C183.5020806@pobox.com> <3D90C3B0.8090507@nortelnetworks.com> <3D90C670.90508@pobox.com> <3D90CACE.595EA229@us.ibm.com> <3D90CC8F.4080706@pobox.com> <3D90D503.8F4CDEB6@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Kessler wrote:
> Event logging uses real-time signaling to notify a process that's registered
> for notification that an event matching the criteria defined during 
> registration has been written to the event log.  When notified, the process
> can read the entire event from the event log and then do whatever.


I've already seen the event logging userspace API, thanks.

Are you saying that netlink is not useful for event delivery inside the 
kernel?  It seems useful to me.  Are you saying that netlink is 
incompatible with the POSIX event logging interface?  My initial 
thinking is that it seems compatible, just the syscalls[interface] is a 
bit different.

Both your messages simply described and re-described POSIX event 
logging, without actually responding to my suggestion.  Are you just 
quoting specifications because you would rather not look into netlink 
and explore new options?

I would rather avoid the kernel bloat of two pieces of kernel code doing 
the pretty much the same thing internally.

	Jeff



