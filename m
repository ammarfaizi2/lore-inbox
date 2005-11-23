Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVKWRkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVKWRkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVKWRkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:40:31 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:7131 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751278AbVKWRka convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:40:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UGc9vxuHgP5u0+UCNbQioPpU/zBxNY4OgY0hBhDbhOmPuzSDyLbmNizKANYfFHsDRAU85d/NRcU2nZiimgWZ0JuiO3XhY5ZlAW0y4t+ZDo2JBcAg6zDPQwY0ZyGbM4ETEG9o0gYlnTOuuc9hB+sacQdcRO301n980M7ADX8Vr7A=
Message-ID: <2ea3fae10511230940t1f6a1757lf885a2559be6f0dc@mail.gmail.com>
Date: Wed, 23 Nov 2005 09:40:28 -0800
From: yhlu <yinghailu@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [LinuxBIOS] x86_64: apic id lift patch
Cc: Ronald G Minnich <rminnich@lanl.gov>, discuss@x86-64.org,
       linuxbios@openbios.org, yhlu <yhlu.kernel@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051123173636.GL20775@brahms.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com>
	 <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov>
	 <2ea3fae10511230919l4d9829d8j3ce5d820b74074d1@mail.gmail.com>
	 <20051123173636.GL20775@brahms.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

is there any way to make the kernel use apci but still use pci irq
routing from mptable?

YH

On 11/23/05, Andi Kleen <ak@suse.de> wrote:
> On Wed, Nov 23, 2005 at 09:19:59AM -0800, yhlu wrote:
> > sth about SRAT in LinuxBIOS,  I have put SRAT dynamically support in
> > LinuxBIOS, but the whole acpi support still need dsdt, current we only have
> > dsdt for AMD chipset in LB. And we can not have the access the dsdt asl from
> > Nvidia chipset yet...
>
> You probably don't need most of it. Just a basic SRAT table (no AML methods)
> and enough to keep the ACPI interpreter from aborting early.
>
> Or alternatively just fix the bug that caused you to go with discontig
> APICs in the first place.
>
> -Andi
>
