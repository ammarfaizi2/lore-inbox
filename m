Return-Path: <linux-kernel-owner+w=401wt.eu-S1751023AbXASPzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXASPzi (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 10:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbXASPzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 10:55:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42839 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXASPzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 10:55:37 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Benjamin Romer <benjamin.romer@unisys.com>
Cc: vgoyal@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Update disable_IO_APIC to use 8-bit destination field  (X86_64)
References: <1169052407.3082.43.camel@ustr-romerbm-2.na.uis.unisys.com>
	<m1tzyp8o8v.fsf@ebiederm.dsl.xmission.com>
	<20070118034153.GA5406@in.ibm.com> <20070118043639.GA12459@in.ibm.com>
	<m1tzyo7qtc.fsf@ebiederm.dsl.xmission.com>
	<20070118080003.GC31860@in.ibm.com>
	<1169141034.6665.6.camel@ustr-romerbm-2.na.uis.unisys.com>
	<m14pqo6w3d.fsf@ebiederm.dsl.xmission.com>
	<1169147619.6665.11.camel@ustr-romerbm-2.na.uis.unisys.com>
	<20070119034944.GA7136@in.ibm.com>
	<1169219470.2819.9.camel@ustr-romerbm-2.na.uis.unisys.com>
Date: Fri, 19 Jan 2007 08:55:19 -0700
In-Reply-To: <1169219470.2819.9.camel@ustr-romerbm-2.na.uis.unisys.com>
	(Benjamin Romer's message of "Fri, 19 Jan 2007 10:11:10 -0500")
Message-ID: <m1lkjz57vc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Romer <benjamin.romer@unisys.com> writes:

> On Fri, 2007-01-19 at 09:19 +0530, Vivek Goyal wrote:
>> On Thu, Jan 18, 2007 at 02:13:39PM -0500, Benjamin Romer wrote:
>> [..]
>> > > >
>> > > > OK, here's the updated patch that uses the new definition and fixes up
>> > > > the other places that use it. I built and tested this on the ES7000/ONE
>> > > > and it works well. :)
>> > >
>> > > Cool.
>> > >
>> > > I hate to pick nits by why the double underscore on dest?
>> > >
>> > 
>> > It was defined that way in the updated structure definition you sent in
>> > a previous mail, so I figured you wanted it that way. Here's another
>> > revision with the double underscores removed. :)
>> > 
>> > -- Ben
>> > 
>> 
>> This patch looks good to me. You might want to provide some description
>> too for changelog.
>> 
>> Thanks
>> Vivek
>
> A simple description would look something like:
>
> - Updated 4-bit IO-APIC physical dest field to 8-bit dest field for
> xAPIC; fixes ES7000/ONE kexec timer hang
>
> Is there a changelog file in the kernel for kexec somewhere, or does
> this belong in the source file's comments somewhere? I can fix up the
> patch as soon as I know where the right spot for the description is. :)

Just send a fresh email:

> Subject: [PATCH] short summary of the patch.
> 
> Description of the patch
> 
> 
> ---
> diffstat
> 
> diff

When imported into git the leading description of the patch becomes
the changelog comments.  What you send the first time that got
this thread started was great.

Eric

