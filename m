Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTH2CLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 22:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbTH2CLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 22:11:46 -0400
Received: from user-0cal2fl.cable.mindspring.com ([24.170.137.245]:4259 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S263893AbTH2CLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 22:11:35 -0400
Message-ID: <3F4EB641.3040107@davehollis.com>
Date: Thu, 28 Aug 2003 22:11:13 -0400
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: "Bryan O'Sullivan" <bos@keyresearch.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] netplug, a daemon that handles network cables getting
 plugged in and out
References: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com> <20030829003426.GF12249@vitelus.com>
In-Reply-To: <20030829003426.GF12249@vitelus.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:

>On Thu, Aug 28, 2003 at 02:21:52PM -0700, Bryan O'Sullivan wrote:
>  
>
>>Netplug is a daemon that responds to network cables being plugged in or
>>out by bringing a network interface up or down.  This is extremely
>>useful for DHCP-managed systems that move around a lot, such as laptops
>>and systems in cluster environments.
>>
>>For more details and download instructions, see the netplug homepage:
>>http://www.red-bean.com/~bos/
>>    
>>
>
>Thank you, thank you, thank you. I was just thinking today how
>annoying it is that whenever I boot up my laptop, dhclient runs and tries
>to get an IP address on the ethernet interface until it's ^C'd. Since
>I often use the Ethernet interface this is not a bad default, but dhclient
>can't even realize on its own that there's no cable plugged in.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
Hmm, that seems to raise the question - why doesn't dhclient just handle 
that?  On a DHCP interface, it's running anyway.  if it paid attention 
to link status, it would know when to re-request an IP.  If you are 
statically assigned, you don't really care anyway.

