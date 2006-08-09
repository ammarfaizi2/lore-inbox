Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWHIOy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWHIOy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 10:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWHIOy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 10:54:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:16026 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750920AbWHIOy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 10:54:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rh22SjrvesTBR/3RLiyW6cnRvYR9AOCx+uwhq9uvQK5t+KpIIYzeUwin3WGOSHbiREmRDBnTpGAoJMeqV042pyspsaxbTOde08auYzGfZR+RP7bhqep/hzc5NbnURlmjqCM1f/+vzF6WPfKdev8AuJErQPyGFO7q4RELwIZ2Gw0=
Message-ID: <f96157c40608090754m1f10e0f2h5fbf3b256d2e55e1@mail.gmail.com>
Date: Wed, 9 Aug 2006 14:54:56 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Joel Jaeggli" <joelja@uoregon.edu>
Subject: Re: Only 3.2G ram out of 4G seen in an i386 box
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060809074815.bec7f32c.joelja@uoregon.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060808101504.GJ2152@stingr.net>
	 <MDEHLPKNGKAHNMBLJOLKKEDCNKAB.davids@webmaster.com>
	 <f96157c40608082351j301efa57n412284f8d28124ef@mail.gmail.com>
	 <20060809074815.bec7f32c.joelja@uoregon.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/06, Joel Jaeggli <joelja@uoregon.edu> wrote:
> On Wed, 9 Aug 2006 08:51:41 +0200
> "gmu 2k6" <gmu2006@gmail.com> wrote:
>
> > >        Are these technical notes supposed to be so funny?
> > >
> > >        DS
> >
> > I guess this is all related to older Intel chipsets, right? I mean the
> > chipset *75X something I'm going to have in the new box I will get
> > soonish will support up to 8 GiB. I hope it does not mean that it will
> > be capped at 7.4GiB although I will only have 4GiB installed for now.
>
> most modern 64 bit x86 systems will relocate this memory hole to somewhere else within the address space (memory hoisting)... You'll probably find the it reappers the first time you buy a system with 1TB of ram...

so what does it mean that one of Xeons here shows me the full 4GiB as
total physical memory via `free`?

btw, the box I'm getting will have the 975X chip and include 4GiB RAM
and if I understood the problem correctly even with 3GiB there will be
some memory lost to mapping-issues besides the HI/LO mem
kernel-reserving issue.
this is what I get on ia32 P4 with 3GiB
             total       used       free     shared    buffers     cached
Mem:       3116108    2608196     507912          0     246652    2039708
and this is what I get on ia32 Xeon with 4GiB
             total       used       free     shared    buffers     cached
Mem:       4087660     268828    3818832          0      57168     103568
