Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTEUHzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTEUHmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:42:37 -0400
Received: from zeus.kernel.org ([204.152.189.113]:58838 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261670AbTEUHl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:41:56 -0400
Message-ID: <3ECB10BD.8070105@zytor.com>
Date: Tue, 20 May 2003 22:38:05 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Martin Schlemmer <azarah@gentoo.org>
CC: Chris Friesen <cfriesen@nortelnetworks.com>,
       Riley Williams <Riley@Williams.Name>,
       David Woodhouse <dwmw2@infradead.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <BKEGKPICNAKILKJKMHCAGECEDBAA.Riley@Williams.Name>	 <3ECA3535.7090608@nortelnetworks.com>  <3ECA60B0.6040402@zytor.com> <1053491987.9142.1474.camel@workshop.saharact.lan>
In-Reply-To: <1053491987.9142.1474.camel@workshop.saharact.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:
> 
> The only issue that we might have, is that <linux/abi/*> will once
> again break many things.  Sure, if we have to fix them once to get
> this fixed for good, why not.
> 
> On the other hand, why not leave it at <linux/*.h> and <asm/*.h>
> as the location of the ABI, and then move all kernel only
> related stuff to <kernel/*.h> (or whatever, just the concept which
> count ...) which can then include whatever it needs form the other
> places (linux/asm)?
> 

Because then there will be a push to be backward compatible, and the 
current structure is hideously poor for this purpose.

	-hpa


