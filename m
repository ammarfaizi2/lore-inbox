Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVBFOjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVBFOjP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 09:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVBFOjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 09:39:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65240 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261176AbVBFOjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 09:39:09 -0500
Message-ID: <42062BFE.7070907@pobox.com>
Date: Sun, 06 Feb 2005 09:38:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Arjan van de Ven <arjan@infradead.org>, Martins Krikis <mkrikis@yahoo.com>,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
References: <87651hdoiv.fsf@yahoo.com> <420582C6.7060407@pobox.com>	 <1107682076.22680.58.camel@laptopd505.fenrus.org> <58cb370e050206044513eb7f89@mail.gmail.com>
In-Reply-To: <58cb370e050206044513eb7f89@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sun, 06 Feb 2005 10:27:56 +0100, Arjan van de Ven
> <arjan@infradead.org> wrote:
> 
>>On Sat, 2005-02-05 at 21:36 -0500, Jeff Garzik wrote:
>>
>>>Martins Krikis wrote:
>>>
>>>>Version 0.1.5 of the Intel Sofware RAID driver (iswraid) is now
>>>>available for the 2.4 series kernels at
>>>>http://prdownloads.sourceforge.net/iswraid/2.4.29-iswraid.patch.gz?download
>>>
>>>ACK from me
>>
>> personally I consider it a new feature, and I don't consider new
>>features like this appropriate for a 2.4 deep maintenance stream.
> 
> 
> I have the same opinion


It sorts sucks for users with that hardware.  The typical complaint 
comes from trying to share data between Windows and Linux, where "just 
use md" isn't a solution.

Without device mapper (another new feature) to enable dmraid, these 
users are just sorta S.O.L.

I consider it not a new feature, but a missing feature, since otherwise 
user data cannot be accessed in the RAID setups.

	Jeff


