Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbWIUWM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWIUWM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbWIUWM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:12:58 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:19908 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751675AbWIUWM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:12:57 -0400
Date: Thu, 21 Sep 2006 15:00:48 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Sean <seanlkml@sympatico.ca>
cc: Dax Kelson <dax@gurulabs.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
In-Reply-To: <BAYC1-PASMTP025A72C81CFE009C3BB5A5AE200@CEZ.ICE>  <20060921175717.272c58ee.seanlkml@sympatico.ca>
Message-ID: <Pine.LNX.4.63.0609211455570.17238@qynat.qvtvafvgr.pbz>
References: <1158870777.24172.23.camel@mentorng.gurulabs.com><20060921204250
 .GN13641@csclub.uwaterloo.ca><20060921171747.9ae2b42e.seanlkml@sympatico.ca
 ><1158874875.24172.47.camel@mentorng.gurulabs.com>
 <BAYC1-PASMTP025A72C81CFE009C3BB5A5AE200@CEZ.ICE> 
 <20060921175717.272c58ee.seanlkml@sympatico.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006, Sean wrote:

> On Thu, 21 Sep 2006 15:41:15 -0600
> Dax Kelson <dax@gurulabs.com> wrote:
>
>>
>> Git users and tarball users are different audiences.
>>
>
> Don't see why that needs to be the case.  Git can even produce the
> tarballs once you've synced up with kernel.org (see git-tar-tree).
> People interested in conserving bandwidth should really consider
> the use of Git.

yes,
   however git users are people who plan on following every kernel version for a 
while, tarball users are people who grab a copy of the kernel once in a while 
(probably not every version). for the tarball users they would have to grab 
multiple patches to get from the last thing that they have to whatever is 
current. and frankly they may not (and probably should not) trust the last thing 
that they have, as in many cases it's a distro patched kernel that may not be 
compatable with the vanilla kernel.

people who start downloading every revision should start useing git or patches, 
but not everyone needs it.

also people could be behind a firewall that prevents git from working properly, 
for them tarballs and patches are the right way of doing things.

David Lang
