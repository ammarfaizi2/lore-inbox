Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261787AbSIXUat>; Tue, 24 Sep 2002 16:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbSIXUat>; Tue, 24 Sep 2002 16:30:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52495 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261787AbSIXUar>;
	Tue, 24 Sep 2002 16:30:47 -0400
Message-ID: <3D90CC8F.4080706@pobox.com>
Date: Tue, 24 Sep 2002 16:35:27 -0400
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
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C183.5020806@pobox.com> <3D90C3B0.8090507@nortelnetworks.com> <3D90C670.90508@pobox.com> <3D90CACE.595EA229@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Kessler wrote:
> Jeff Garzik wrote:
>>To address your more general point, a general way to notify interested,
>>credentialed (is that a word?) 3rd party processes of device events
>>would indeed be useful.  Since such events are essential out-of-band
>>info, netlink might indeed be applicable.
> 
> 
> Event Logging has both a command and an API for apps in user-space to
> register for specific events (kernel or userspace).   The user must have
> read access to the log file and the proper credentials in the allow/deny 
> file scheme (that's modeled after crontab). 


Ok.  And?  It sounds like event logging could possibly use netlink as 
the event delivery mechanism.

	Jeff



