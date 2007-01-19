Return-Path: <linux-kernel-owner+w=401wt.eu-S932579AbXASROR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbXASROR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbXASROR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:14:17 -0500
Received: from usea-naimss3.unisys.com ([192.61.61.105]:4603 "EHLO
	usea-naimss3.unisys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579AbXASROQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:14:16 -0500
Subject: Re: PATCH: Update disable_IO_APIC to use 8-bit destination field 
	(X86_64)
From: Benjamin Romer <benjamin.romer@unisys.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20070119074333.ae9d351b.rdunlap@xenotime.net>
References: <1169052407.3082.43.camel@ustr-romerbm-2.na.uis.unisys.com>
	 <m1tz yp8o8v.fsf@ebiederm.dsl.xmission.com>
	 <20070118034153.GA5406@in.ibm.com><200 70118043639.GA12459@in.ibm.com>
	 <m1tzyo7qtc.fsf@ebiederm.dsl.xmission.com>
	 <2 0070118080003.GC31860@in.ibm.com>
	 <1169141034.6665.6.camel@ustr-romerbm-2.na .uis.unisys.com>
	 <m14pqo6w3d.fsf@ebiederm.dsl.xmission.com>
	 <1169147619.6665. 11.camel@ustr-romerbm-2.na.uis.unisys.com>
	 <20070119034944.GA7136@in.ibm.com >
	 <1169219470.2819.9.camel@ustr-romerbm-2.na.uis.unisys.com>
	 <20070119074333.ae9d351b.rdunlap@xenotime.net>
Content-Type: text/plain
Organization: Unisys Corporation
Date: Fri, 19 Jan 2007 12:14:13 -0500
Message-Id: <1169226853.6467.16.camel@ustr-romerbm-2.na.uis.unisys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jan 2007 17:14:14.0578 (UTC) FILETIME=[3E88A920:01C73BED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-19 at 07:43 -0800, Randy Dunlap wrote:
> On Fri, 19 Jan 2007 10:11:10 -0500 Benjamin Romer wrote:
> 
> > On Fri, 2007-01-19 at 09:19 +0530, Vivek Goyal wrote:
> > > On Thu, Jan 18, 2007 at 02:13:39PM -0500, Benjamin Romer wrote:
> > > [..]
> > > > > >
> > > > > > OK, here's the updated patch that uses the new definition and fixes up
> > > > > > the other places that use it. I built and tested this on the ES7000/ONE
> > > > > > and it works well. :)
> > > > >
> > > > > Cool.
> > > > >
> > > > > I hate to pick nits by why the double underscore on dest?
> > > > >
> > > > 
> > > > It was defined that way in the updated structure definition you sent in
> > > > a previous mail, so I figured you wanted it that way. Here's another
> > > > revision with the double underscores removed. :)
> > > > 
> > > > -- Ben
> > > > 
> > > 
> > > This patch looks good to me. You might want to provide some description
> > > too for changelog.
> > > 
> > > Thanks
> > > Vivek
> > 
> > A simple description would look something like:
> > 
> > - Updated 4-bit IO-APIC physical dest field to 8-bit dest field for
> > xAPIC; fixes ES7000/ONE kexec timer hang
> > 
> > Is there a changelog file in the kernel for kexec somewhere, or does
> > this belong in the source file's comments somewhere? I can fix up the
> > patch as soon as I know where the right spot for the description is. :)
> 
> We use a source code management system for changelogs. (git)
> 
> Patch comments (changelog info) go in the email at the top of the
> patch.  See Documentation/SubmittingPatches and
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
> and http://linux.yyz.us/patch-format.html for more info.
> 
> ---
> ~Randy

Thanks for the pointers! I've bookmarked them for future reference, and
sent a new patch that follows the guidelines. :)

-- Ben

