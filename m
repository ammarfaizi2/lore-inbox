Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261774AbSIXTxb>; Tue, 24 Sep 2002 15:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbSIXTxb>; Tue, 24 Sep 2002 15:53:31 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:25554 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S261774AbSIXTxa>; Tue, 24 Sep 2002 15:53:30 -0400
Message-ID: <3D90C3B0.8090507@nortelnetworks.com>
Date: Tue, 24 Sep 2002 15:57:36 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: alternate event logging proposal
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C183.5020806@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> "What do you want to log?" is as important to me as "how do you want to 
> log it?"  And the answers to the two questions are very much intertwined.

Also related is "how can userspace be notified of kernel events?". 
There is no way for a userspace app to be notified that, for instance, 
an ATM device got a loss of signal.  The drivers print it out, but the 
userspace app has no clue.

I think that there should be a relatively generic way for drivers to 
distribute events such as this and for userspace to register interest in 
them.

Maybe netlink is the way to go, but its not exactly a simple interface.

Chris

