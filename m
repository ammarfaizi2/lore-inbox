Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTH1Wes (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTH1Wes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:34:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22743 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264478AbTH1Wer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:34:47 -0400
Message-ID: <3F4E8373.1040204@pobox.com>
Date: Thu, 28 Aug 2003 18:34:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: "Bryan O'Sullivan" <bos@keyresearch.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] netplug, a daemon that handles network cables getting
 plugged in and out
References: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com> <20030828215417.GA22215@werewolf.able.es>
In-Reply-To: <20030828215417.GA22215@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 08.28, Bryan O'Sullivan wrote:
> 
>>Netplug is a daemon that responds to network cables being plugged in or
>>out by bringing a network interface up or down.  This is extremely
>>useful for DHCP-managed systems that move around a lot, such as laptops
>>and systems in cluster environments.
>>
>>For more details and download instructions, see the netplug homepage:
>>http://www.red-bean.com/~bos/
>>
> 
> 
> I feel sorry, but did you ever knew this existed ?
> 
> http://www.stud.uni-hamburg.de/users/lennart/projects/ifplugd/


ifplugd doesn't appear to use netlink.  Did I miss something?

netlink is definitely the preferred way to get link notification.  Maybe 
the two authors can work together to merge the best parts of both...

	Jeff



