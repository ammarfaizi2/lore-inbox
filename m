Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbUCWVPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbUCWVPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:15:22 -0500
Received: from pop.gmx.de ([213.165.64.20]:6555 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262825AbUCWVPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 16:15:18 -0500
X-Authenticated: #7370606
Message-ID: <4060A8E0.7020905@gmx.at>
Date: Tue, 23 Mar 2004 22:15:12 +0100
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Device mapper devel list <dm-devel@redhat.com>,
       Thomas Horsten <thomas@horsten.com>, medley@lists.infowares.com
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com> <20040321074711.GA13232@devserv.devel.redhat.com> <405D9CDA.6070107@gmx.at> <405F3B1C.3030500@gmx.net> <405F3EA8.6060606@pobox.com>
In-Reply-To: <405F3EA8.6060606@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Carl-Daniel Hailfinger wrote:
> 
>>> 4. nice clickety-click user interface
>>> Especially useful for lazy people like me. ;)
>>
>>
>>
>> I prefer the "no user interface" approach. But then again, I'm biased.
> 
> 
> Agreed -- a minimal implementation is needed first anyway.  The BIOS of 
> these proprietary RAID thingies typically provides the user interface.

On the other hand EVMS allowed me to make a minimal solution by taking 
care of the partitioning and the DM-API in the EVMS framework. The user 
interface is just an add-on that comes with the package. Right now its 
just a way for the user to get a "look its really there". If we do the 
RAID configuration and writeing the configuration blocks to the disks or 
not is in your hands. When we consider this to be to risky then lets 
just skip it.

Regards,
Wilfried
