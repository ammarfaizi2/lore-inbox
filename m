Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbTF1N40 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 09:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbTF1N40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 09:56:26 -0400
Received: from franka.aracnet.com ([216.99.193.44]:55257 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265219AbTF1N4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 09:56:25 -0400
Date: Sat, 28 Jun 2003 07:10:26 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Szonyi Calin <sony@etc.utt.ro>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73-mjb2
Message-ID: <43530000.1056809425@[10.10.2.4]>
In-Reply-To: <39714.194.138.39.55.1056809147.squirrel@webmail.etc.utt.ro>
References: <36540000.1056736708@[10.10.2.4]> <39714.194.138.39.55.1056809147.squirrel@webmail.etc.utt.ro>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Martin J. Bligh said:
>> The patchset contains mainly scalability and NUMA stuff, and anything
>> else that stops things from irritating me. It's meant to be pretty
>> stable,  not so much a testing ground for new stuff.
>> 
>> I'd be very interested in feedback from anyone willing to test on any
>> platform, however large or small.
>> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.73/patch-2.5.73-mjb2.bz2
>> 
> 
> Are you interested in behaviour of this kernel on uniprocessor machines ?

Yup.

> I tested 2.5.72-mjb2 but it was full of oopses and crashes on my Duron
> so I thought this patch is only for NUMA stuff.

Nope, it should work with any machine  - you got the oopses?

If you have an old distro with glibc < 2.3.1, Bill thinks the upside_down
trick doesn't work because of some invalid assumptions glibc is making.
If that's the case, could you check that 2.5.73-mjb1 works OK?

Thanks,

M.

