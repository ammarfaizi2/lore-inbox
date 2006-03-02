Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWCBWgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWCBWgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 17:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWCBWgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 17:36:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17297 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750924AbWCBWgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 17:36:48 -0500
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Laurent Riffard" <laurent.riffard@free.fr>,
       linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
       "Martin Bligh" <mbligh@mbligh.org>,
       "Christoph Lameter" <clameter@engr.sgi.com>
Subject: Re: 2.6.16-rc5-mm1
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org>
	<9a8748490603011741o122e652ica20a9fcffed3d41@mail.gmail.com>
	<9a8748490603021216u344a3915g6ca0df42bb51b867@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 02 Mar 2006 15:34:17 -0700
In-Reply-To: <9a8748490603021216u344a3915g6ca0df42bb51b867@mail.gmail.com> (Jesper
 Juhl's message of "Thu, 2 Mar 2006 21:16:32 +0100")
Message-ID: <m1veuwiihi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> writes:

> On 3/2/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>> On 3/1/06, Andrew Morton <akpm@osdl.org> wrote:
>> >
>> > Could people please test a couple more patchsets, see if we can isolate it?
>> >
>> > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.1.gz
>> >
>>
>> Haven't had time to test this one yet, and won't have time until tomorrow :(
>>
>
> I just tested this kernel and it builds and runs just fine. Can't
> crash it with my eclipse test case.
>
>>
>> > and http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.2.gz is
>>
>> I've tested this one and I can't crash it with eclipse like I could
>> plain old 2.6.16-rc5-mm1
>>
>
> With all the recent patches and proposed patches and discussions about
> various approaches to fix this I've lost track.
>
> What kernel with what patches applied and/or reverted would it make
> the most sense for me to test now, in order to provide the most useful
> testing?

So it looks like we have this tracked and fixed.  Andrew included my
fix in:
http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm2-pre1.gz

So just confirming that the fixed actually worked would probably be
the biggest help.

The problem should be fixed unless there is something else that
triggers the horrible and mysterious kernel death.  So you are
getting the same results as everyone else.


Eric
