Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263055AbTCWNac>; Sun, 23 Mar 2003 08:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263057AbTCWNac>; Sun, 23 Mar 2003 08:30:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57223 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263055AbTCWNab>;
	Sun, 23 Mar 2003 08:30:31 -0500
Message-ID: <3E7DB99B.5050509@pobox.com>
Date: Sun, 23 Mar 2003 08:41:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Pavel Machek <pavel@ucw.cz>, szepe@pinerecords.com, arjanv@redhat.com,
       alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
References: <200303171604.h2HG4Zc30291@devserv.devel.redhat.com>	<1047923841.1600.3.camel@laptop.fenrus.com>	<20030317182040.GA2145@louise.pinerecords.com>	<20030317182709.GA27116@gtf.org>	<20030321211708.GC12211@zaurus.ucw.cz> <20030323110052.5267cba8.skraw@ithnet.com>
In-Reply-To: <20030323110052.5267cba8.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> On Fri, 21 Mar 2003 22:17:08 +0100
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> 
>>Hi!
>>
>>
>>>>Would it make sense to repackage 2.4.20 into something like 2.4.20-p1
>>>>or 2.4.20.1 with only the critical stuff applied?
>>>
>>>There shouldn't be a huge need to rush 2.4.21 as-is, really.  If you
>>>want an immediate update, get the fix from your vendor.
> 
> 
> Sorry Jeff,
> 
> this comment must obviously be flagged with a big community-buh. It is very
> likely that most readers of LKML read/write here _not_ because they are
> looking for a _vendor_ specific thing, but because they feel to a certain
> extent as part of a linux-community and (partly) want to give something back
> for the good things they got from it.
> It is no hot news over here that linux does _not_ live because of 5 different
> (or more?) "vendor"-kernels, but solely because there is _the_ official
> kernel.org kernel (releases). 
[...]
> So IMHO: if there is a-known-to-work patch for the discussed exploit it should
> be released as _some_ (pre-)release for 2.4 quickly, and thanks must go to alan
> for taking quick approach on 2.2.


I think you misunderstand my point:  there was a patch posted which 
fixes the ptrace issue.  If you want to fix your kernel, there are two 
options:  either you are capable enough apply that patch yourself, 
otherwise get a kernel update from a vendor.  Marcelo is under no 
obligation to provide hot-fix kernels...

As for Alan, his task was easier:  Guess how many patches are in 2.2.25? 
  One.  ;-)

	Jeff



