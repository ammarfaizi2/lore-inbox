Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267632AbSLNQGE>; Sat, 14 Dec 2002 11:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267633AbSLNQGD>; Sat, 14 Dec 2002 11:06:03 -0500
Received: from icarus.com ([208.36.26.146]:2688 "EHLO icarus.com")
	by vger.kernel.org with ESMTP id <S267632AbSLNQGD>;
	Sat, 14 Dec 2002 11:06:03 -0500
Message-Id: <200212141613.gBEGDpn01305@icarus.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Falk Hueffner falk.hueffner-at-student.uni-tuebingen.de |linux kernel
	mailing list|" <zg8oh727vc0t@sneakemail.com>
cc: linux-kernel@vger.kernel.org, axp-list@redhat.com
Subject: Re: Linux/alpha vs. 2.4.20 and ISO9660 vs long file names 
In-Reply-To: Message from "Falk Hueffner falk.hueffner-at-student.uni-tuebingen.de |linux kernel mailing list|" <zg8oh727vc0t@sneakemail.com> 
   of "13 Dec 2002 14:22:57 +0100." <87vg1yjbny.fsf@student.uni-tuebingen.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 14 Dec 2002 08:13:51 -0800
From: Stephen Williams <steve@icarus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Stephen Williams" <zhig9f05jg02@sneakemail.com> writes:

> For some reason, ls is having trouble with long file names on the
> disk. I follow with strace, and getdents64 is returning the right
> number of entries, but then ls tries to lstat a truncated name.  I
> can't say of the getdirent64 is trundating the name, but it seems
> likely.


zg8oh727vc0t@sneakemail.com said:
> This might be caused by a bug in stxcpy. Please try 2.4.210-pre1,
> which contains a patch by Ivan Kokshaysky for this. 

2.4.21-pre1 seems to have cured my symptoms, so I'm satisfied.
I guess that means that vanilla 2.4.20 is not right for alphas.
Thanks for the suggestion.
-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
steve at picturel.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


