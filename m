Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263214AbTC1Xoy>; Fri, 28 Mar 2003 18:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263216AbTC1Xoy>; Fri, 28 Mar 2003 18:44:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10115 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263214AbTC1Xox>;
	Fri, 28 Mar 2003 18:44:53 -0500
Message-ID: <3E84E126.2040103@pobox.com>
Date: Fri, 28 Mar 2003 18:56:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@digeo.com>,
       davej@codemonkey.org.uk, linux-kernel@vger.kernel.org, aeb@cwi.nl
Subject: Re: NICs trading places ?
References: <20030328221037.GB25846@suse.de> <20030328224843.GA11980@win.tue.nl> <20030328150234.7f73d916.akpm@digeo.com> <20030328232022.GA12005@win.tue.nl> <20030328234114.GA992@kroah.com>
In-Reply-To: <20030328234114.GA992@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Mar 29, 2003 at 12:20:22AM +0100, Andries Brouwer wrote:
> 
>>And: ifconfig does not give the card types.
>>So presently one needs both boot messages and ifconfig.
>>
>>And: in some situations the system does not boot because of
>>eth numbering mixup, and one never gets the opportunity to
>>ask ifconfig.
> 
> 
> ifconfig can bind cards to devices based on mac addresses.
> /sbin/hotplug can also be used for this.
> 
> I recommend doing this for anyone with more than one nic card in their
> machine.


Actually nameif(8) is the preferred way of doing this.

	Jeff



