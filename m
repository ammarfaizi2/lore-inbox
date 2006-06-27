Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933329AbWF0Cms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933329AbWF0Cms (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 22:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933335AbWF0Cms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 22:42:48 -0400
Received: from koto.vergenet.net ([210.128.90.7]:17858 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S933329AbWF0Cmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 22:42:47 -0400
From: Horms <horms@verge.net.au>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andrew Morton <akpm@osdl.org>, Neela.Kolli@engenio.com,
       linux-scsi@vger.kernel.org, mike.miller@hp.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [RFC] [PATCH 2/2] kdump: cciss driver initialization?issue fix
In-Reply-To: <m11wtcvw5k.fsf@ebiederm.dsl.xmission.com>
X-Newsgroups: gmane.comp.boot-loaders.fastboot.general,gmane.linux.scsi,gmane.linux.kernel
User-Agent: tin/1.8.2-20060425 ("Shillay") (UNIX) (Linux/2.6.16-2-686 (i686))
Message-Id: <20060627024245.9B2E634053@koto.vergenet.net>
Date: Tue, 27 Jun 2006 11:42:45 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m11wtcvw5k.fsf@ebiederm.dsl.xmission.com> you wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
>> On Mon, Jun 26, 2006 at 07:41:00AM +0530, Maneesh Soni wrote:
>>
>> Maneesh, Keeping this code under a config option becomes a problem when we
>> will have a relocatable kernel. At some point of time we got to have
>> relocatable kernel so that people don't have to build two kernels. In fact
>> this is becoming a pain area for distros. That's the reason I thought
>> of making it a command line parameter.
> 
> Ok. Even if we do this with a command line, we need to have a clean concept.
> If the concept is ignore devices with a brittle init routine that is compre=
> hensible
> and potentially useful for other reasons than crash dumps.
> 
> If the concept is crashdump it is a poorly defined concept and all of Andre=
> ws
> objections apply.
> 
>> I remember few months back, Eric had mentioned that he has got patches for
>> relocatable kernel ready for review for i386 and x86_64. Eric, do you have
>> any plans to post the patches for review?
> 
> I have some code that I keep intending to get to.  It has probably bit
> rotted since I wrote it, but it shouldn't be too bad to clean up.
> Unfortunately the whole crashdump thing is fairly low on my priority
> list.

Hi Eric,

If you have some code to relocate the i386 and x86_64 kernels then I for
one would really like a chance to look over it.

-- 
Horms                                           
H: http://www.vergenet.net/~horms/          W: http://www.valinux.co.jp/en/

