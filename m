Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285068AbRLLD0K>; Tue, 11 Dec 2001 22:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285070AbRLLD0A>; Tue, 11 Dec 2001 22:26:00 -0500
Received: from ftoomsh.progsoc.uts.edu.au ([138.25.6.1]:11531 "EHLO ftoomsh")
	by vger.kernel.org with ESMTP id <S285068AbRLLDZq>;
	Tue, 11 Dec 2001 22:25:46 -0500
Date: Wed, 12 Dec 2001 14:25:38 +1100
From: Matt <matt@progsoc.uts.edu.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Berend De Schouwer <bds@jhb.ucs.co.za>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel Oops on cat /proc/ioports
Message-ID: <20011212142538.N5809@ftoomsh.progsoc.uts.edu.au>
In-Reply-To: <1008073796.5535.5.camel@bds.ucs.co.za> <3C16ADB1.F9E847E9@zip.com.au>, <3C16ADB1.F9E847E9@zip.com.au>; <20011212135713.M5809@ftoomsh.progsoc.uts.edu.au> <3C16CA8F.722CB6BB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C16CA8F.722CB6BB@zip.com.au>; from akpm@zip.com.au on Tue, Dec 11, 2001 at 07:10:07PM -0800
X-OperatingSystem: Linux ftoomsh.progsoc.uts.edu.au 2.2.15-pre13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 07:10:07PM -0800, Andrew Morton wrote:
> Matt wrote:

>> speaking of living in module memory, a similar thing happens with
>> the via-rhine driver. after my machine has been up for a few hours
>> the "via-rhine" string in /proc/iomem and /proc/ioports gets over
>> written and prints garbage. since this has never been the cause for
>> an oops on my machine i never bothered reporting it. if anyone
>> wants details i'll provide.

> I think it _could_ oops.  Would it be correct to assume that you're
> linking the driver into the kernel, rather than using it as a
> module?

you are most correct, it is directly linked. i'll give it a burl. i
assume you are going to submit this to donald/jeff and marcelo?

	matt

