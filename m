Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTJKIlq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 04:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTJKIlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 04:41:46 -0400
Received: from mail.convergence.de ([212.84.236.4]:53913 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263260AbTJKIlp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 04:41:45 -0400
Message-ID: <3F87C247.7030808@convergence.de>
Date: Sat, 11 Oct 2003 10:41:43 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-dvb <linux-dvb@linuxtv.org>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/14] LinuxTV.org DVB driver update
References: <10656197274033@convergence.de> <20031010131538.74b78a14.shemminger@osdl.org>
In-Reply-To: <20031010131538.74b78a14.shemminger@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

> This update broke the dvb network device changes to make it work with the
> new rules about dynamic allocation for 2.6.  It reverts the code to getting
> the network device out of an array, so it will break if:
> 	rmmod dvb_net </sys/class/net/dvb0_0/mtu
> See:
> 	Documentation/net/netdevices.txt

Thanks for spotting this, although I don't know what has gone wrong here 
yet. (I don't know the DVB net code very well).

I'll review this, have a talk with the original author and then send an 
update patch.

Unfortunately, I don't notice every patch that goes directly into 2.6 
without getting postet on the linux-dvb mailinglist. Now if someone 
changes stuff in our CVS in the same file, it can happen that the stuff 
from the kernel is wiped out.

CU
Michael.


