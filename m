Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277001AbRJKW3A>; Thu, 11 Oct 2001 18:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277000AbRJKW2u>; Thu, 11 Oct 2001 18:28:50 -0400
Received: from jalon.able.es ([212.97.163.2]:59078 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S276990AbRJKW2e>;
	Thu, 11 Oct 2001 18:28:34 -0400
Date: Fri, 12 Oct 2001 00:28:59 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Corin Hartland-Swann <cdhs@commerce.uk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with lo and AF_NETLINK
Message-ID: <20011012002859.E18540@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.21.0110111730250.25144-100000@willow.commerce.uk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0110111730250.25144-100000@willow.commerce.uk.net>; from cdhs@commerce.uk.net on Thu, Oct 11, 2001 at 18:37:10 +0200
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011011 Corin Hartland-Swann wrote:
>
>As the previous poster suggested, I have tried re-compiling with
>CONFIG_NETLINK_DEV, but that didn't help, and I am still getting:
>
>  Cannot send dump request: Connection refused
>

My actual setup (2.4.10-ac12) is:

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y

But the origin of the question wast that 'pump' DHCP client stopped working.
No I have switched to dhcp-client-3.0-1mdk.

Anybody has pump working with newer kernels ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.10-ac12-beo #6 SMP Thu Oct 11 17:41:34 CEST 2001 i686
