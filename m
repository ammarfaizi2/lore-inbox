Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261781AbSIXUYN>; Tue, 24 Sep 2002 16:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbSIXUYN>; Tue, 24 Sep 2002 16:24:13 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:64991 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261781AbSIXUYM>;
	Tue, 24 Sep 2002 16:24:12 -0400
Message-ID: <3D90CACE.595EA229@us.ibm.com>
Date: Tue, 24 Sep 2002 13:27:58 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [evlog-dev] Re: alternate event logging proposal
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C183.5020806@pobox.com> <3D90C3B0.8090507@nortelnetworks.com> <3D90C670.90508@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Chris Friesen wrote:
> > Also related is "how can userspace be notified of kernel events?". There
> > is no way for a userspace app to be notified that, for instance, an ATM
> > device got a loss of signal.  The drivers print it out, but the
> > userspace app has no clue.
> 
> (sorry for the second reply)
> 
> To address your more general point, a general way to notify interested,
> credentialed (is that a word?) 3rd party processes of device events
> would indeed be useful.  Since such events are essential out-of-band
> info, netlink might indeed be applicable.

Event Logging has both a command and an API for apps in user-space to
register for specific events (kernel or userspace).   The user must have
read access to the log file and the proper credentials in the allow/deny 
file scheme (that's modeled after crontab). 

Larry Kessler
http://evlog.sourceforge.net/
