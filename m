Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTFFB7B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 21:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbTFFB7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 21:59:01 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:196 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP id S264495AbTFFB7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 21:59:00 -0400
Message-ID: <3EDFFC01.2060002@attbi.com>
Date: Thu, 05 Jun 2003 22:27:13 -0400
From: "George G. Davis" <davis_g@attbi.com>
Reply-To: davis_g@attbi.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021128
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: joe briggs <jbriggs@briggsmedia.com>
CC: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: HELP!! REDHAT QUESTION
References: <200306051406.h55E6Yp25484@devserv.devel.redhat.com> <200306052258.32331.jbriggs@briggsmedia.com>
In-Reply-To: <200306052258.32331.jbriggs@briggsmedia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joe briggs wrote:
> Please help.  I have a redhat 7.3 computer accross the country that was 
> installed using the WORKSTATION option.  I desperately need to telnet into 
> it, but with the new xinetd.d stuff, don't know how.  Can ANYBODY tell me how 
> to get the telnet deamon running on this box so that I can remotely log in?
> 

Hi Joe,

There's probably an admin tool for this, but:

	sed /disable/s/no/yes/ /etc/xinetd.d/telnet


However, if it's "accross the country", you probably should be running sshd
instead. : )

HTH!

--
Regards,
George


> 


