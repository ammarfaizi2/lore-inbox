Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264469AbRFORJs>; Fri, 15 Jun 2001 13:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264468AbRFORJi>; Fri, 15 Jun 2001 13:09:38 -0400
Received: from web12208.mail.yahoo.com ([216.136.173.92]:19 "HELO
	web12208.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264463AbRFORJ3>; Fri, 15 Jun 2001 13:09:29 -0400
Message-ID: <20010615170928.9505.qmail@web12208.mail.yahoo.com>
Date: Fri, 15 Jun 2001 10:09:28 -0700 (PDT)
From: Manoj Sontakke <manojs49@yahoo.com>
Reply-To: manojs@sasken.com
Subject: Next hop and o/p i/f IP address
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list
        Sorry to bother you with such a trivial query.

To make a routing decision ip_route_input() is called. It fills the skb->dst
with appropriate entry. Can anyone point to the exact location where I can find
the next hop and output interface IP address.

It seems
skb->dst->dev->ip_ptr->in_dev->ifa_list->ifa_address is o/p i/f ip address and
skb->dst->neighbour->dev->ip_ptr->in_dev->ifa_list->ifa_address  is next hop IP
										address

Please correct me if I am wrong.
Thanks for all the help.

Manoj

__________________________________________________
Do You Yahoo!?
Spot the hottest trends in music, movies, and more.
http://buzz.yahoo.com/
