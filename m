Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUCVTaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUCVTaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:30:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27530 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262304AbUCVTaB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:30:01 -0500
Message-ID: <405F3EA8.6060606@pobox.com>
Date: Mon, 22 Mar 2004 14:29:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
CC: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Device mapper devel list <dm-devel@redhat.com>,
       Thomas Horsten <thomas@horsten.com>, medley@lists.infowares.com
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com> <20040321074711.GA13232@devserv.devel.redhat.com> <405D9CDA.6070107@gmx.at> <405F3B1C.3030500@gmx.net>
In-Reply-To: <405F3B1C.3030500@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Wilfried Weissmann wrote:
> 
>>Arjan van de Ven wrote:
>>
>>
>>>On Sat, Mar 20, 2004 at 07:23:01PM -0700, Kevin P. Fleming wrote:
>>>
>>>
>>>>Jeff Garzik wrote:
>>>>
>>>>
>>>>
>>>>>So go ahead, and I'll lend you as much help as I can.  I have the
>>>>>full Promise RAID docs, and it seems like another guy on the lists
>>>>>has full Silicon Image "medley" RAID docs...
> 
> 
> Jeff: May I request your docs?

Unfortunately not, but I can get you in touch with somebody at Promise 
who can.  They're definitely interested in working with the open source 
community.  Not public...


> Well, I had something in mind which closely resembles the ataraid-detect
> tool Thomas Horsten (Medley RAID) suggested.
> 
> http://lists.infowares.com/archive/medley/2004-February/000001.html
> 
> OK, I was even aiming for less: Write an ataraid-detect tool which outputs
> the correct mapping for dmsetup. If I manage to write it generically
> enough, it can be integrated into evms or used as a standalone program,
> whatever you like.

That's pretty nice.  Very Unix-ish:  provide a small, pluggable piece 
that does one thing, and does it well.


>>1. its all within evms
>>There is no need for additional tools required to setup the volume
>>(thinking about installers and initrd...).
> 
> 
> The EVMS sample initrd is HUGE. (2.1 MB) I'm aiming for a initrd size of
> less than 1/10 of that.

Cool :)


>>4. nice clickety-click user interface
>>Especially useful for lazy people like me. ;)
> 
> 
> I prefer the "no user interface" approach. But then again, I'm biased.

Agreed -- a minimal implementation is needed first anyway.  The BIOS of 
these proprietary RAID thingies typically provides the user interface.


>>What do you think?
> 
> 
> I'll use your work as a foundation. First step is integrating detection
> for non-HPT arrays. If the code looks too messy after that, I still can
> refactor it.
> 
> As soon as I have some code to get at least PDCRAID working, I'll post again.

Feel free to ask me questions, too.

	Jeff



