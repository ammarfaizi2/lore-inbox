Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUDADQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 22:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUDADQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 22:16:40 -0500
Received: from mail.gmx.de ([213.165.64.20]:60136 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262103AbUDADQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 22:16:38 -0500
X-Authenticated: #21910825
Message-ID: <406B8A3D.9030405@gmx.net>
Date: Thu, 01 Apr 2004 05:19:25 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Device mapper devel list <dm-devel@redhat.com>,
       Thomas Horsten <thomas@horsten.com>, medley@lists.infowares.com
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com> <20040321074711.GA13232@devserv.devel.redhat.com> <405D9CDA.6070107@gmx.at> <405F3B1C.3030500@gmx.net> <405F3EA8.6060606@pobox.com>
In-Reply-To: <405F3EA8.6060606@pobox.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Carl-Daniel Hailfinger wrote:
> 
>> Wilfried Weissmann wrote:
>>
>>> Arjan van de Ven wrote:
>>>
>>>
>>>> On Sat, Mar 20, 2004 at 07:23:01PM -0700, Kevin P. Fleming wrote:
>>>>
>>>>
>>>>> Jeff Garzik wrote:
>>>>>
>>>>>
>>>>>> So go ahead, and I'll lend you as much help as I can.  I have the
>>>>>> full Promise RAID docs, and it seems like another guy on the lists
>>>>>> has full Silicon Image "medley" RAID docs...
>>
>>
>> Jeff: May I request your docs?
> 
> Unfortunately not, but I can get you in touch with somebody at Promise
> who can.  They're definitely interested in working with the open source
> community.  Not public...

Could you please send me the contact information via private mail?
Thanks.

>> I'll use your work as a foundation. First step is integrating detection
>> for non-HPT arrays. If the code looks too messy after that, I still can
>> refactor it.
>>
>> As soon as I have some code to get at least PDCRAID working, I'll post
>> again.
> 
> 
> Feel free to ask me questions, too.

OK. First question: calc_pdcblock_offset calculates the superblock
location based on capacity, sectors and heads. However, the same machine
which showed 255 heads under Kernel 2.4 now shows only 16 heads and some
of the hardcoded location calculation routines may fail. Is there a
userspace generic method for finding the right sector?
(It works sometimes for me.)

If the answer to above question is also considered confidential, please
feel free to NOT answer to the list.


Regards,
Carl-Daniel

