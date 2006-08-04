Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161452AbWHDVFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161452AbWHDVFq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161458AbWHDVFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:05:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60105 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161452AbWHDVFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:05:45 -0400
Date: Fri, 4 Aug 2006 17:08:27 -0400
From: Don Zickus <dzickus@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060804210826.GE16231@redhat.com>
References: <20060705222448.GC992@in.ibm.com> <aec7e5c30607051932r49bbcc7eh2c190daa06859dcc@mail.gmail.com> <20060706081520.GB28225@host0.dyn.jankratochvil.net> <aec7e5c30607070147g657d2624qa93a145dd4515484@mail.gmail.com> <20060707133518.GA15810@in.ibm.com> <20060707143519.GB13097@host0.dyn.jankratochvil.net> <20060710233219.GF16215@in.ibm.com> <20060711010815.GB1021@host0.dyn.jankratochvil.net> <m1d5c92yv4.fsf@ebiederm.dsl.xmission.com> <m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 10:19:04AM -0600, Eric W. Biederman wrote:
> 
> I have spent some time and have gotten my relocatable kernel patches
> working against the latest kernels.  I intend to push this upstream
> shortly.
> 
> Could all of the people who care take a look and test this out
> to make certain that it doesn't just work on my test box?

Is there any reason to get following error on x86_64 using your patches?

 Filesystem type is ext2fs, partition type 0x83
kernel /bzImage ro root=LABEL=/1 console=ttyS0,115200
earlyprintk=ttyS0,115200
   [Linux-bzImage, setup=0x1c00, size=0x24917c]
initrd /initrd-2.6.18-rc3.img
   [Linux-initrd @ 0x37e0d000, 0x1e25e7 bytes]

.
Decompressing Linux...

length error

 -- System halted


I can get i386 to boot fine.  I can't for the life of me figure out what I
am doing wrong..

Cheers,
Don

