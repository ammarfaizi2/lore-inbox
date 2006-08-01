Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751728AbWHARmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWHARmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbWHARmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:42:06 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:35350 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1751728AbWHARmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:42:03 -0400
Message-ID: <44CF9267.7050202@slaphack.com>
Date: Tue, 01 Aug 2006 12:41:59 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Gregory Maxwell <gmaxwell@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607312314.37863.bernd-schubert@gmx.de>	 <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>	 <20060801165234.9448cb6f.reiser4@blinkenlights.ch>	 <1154446189.15540.43.camel@localhost.localdomain>	 <44CF84F0.8080303@slaphack.com> <e692861c0608011004x2ac1d9fcu353cd8e0d72eaac4@mail.gmail.com>
In-Reply-To: <e692861c0608011004x2ac1d9fcu353cd8e0d72eaac4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:
> On 8/1/06, David Masover <ninja@slaphack.com> wrote:
>> Yikes.  Undetected.
>>
>> Wait, what?  Disks, at least, would be protected by RAID.  Are you
>> telling me RAID won't detect such an error?
> 
> Unless the disk ECC catches it raid won't know anything is wrong.
> 
> This is why ZFS offers block checksums... it can then try all the
> permutations of raid regens to find a solution which gives the right
> checksum.

Isn't there a way to do this at the block layer?  Something in 
device-mapper?

> Every level of the system must be paranoid and take measure to avoid
> corruption if the system is to avoid it... it's a tough problem. It
> seems that the ZFS folks have addressed this challenge by building as
> much of what is classically separate layers into one part.

Sounds like bad design to me, and I can point to the antipattern, but 
what do I know?
