Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSKMTK7>; Wed, 13 Nov 2002 14:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSKMTK7>; Wed, 13 Nov 2002 14:10:59 -0500
Received: from [196.12.44.6] ([196.12.44.6]:50141 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S262783AbSKMTK6>;
	Wed, 13 Nov 2002 14:10:58 -0500
Date: Thu, 14 Nov 2002 00:44:30 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: Bruce Walker <bruce@kahuna.lax.cpqcorp.net>
cc: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ssic-linux-devel <ssic-linux-devel@lists.sourceforge.net>
Subject: Re: [SSI] Re: Distributed Linux
In-Reply-To: <Pine.LNX.4.44.0211140023310.6182-100000@students.iiit.net>
Message-ID: <Pine.LNX.4.44.0211140041590.12536-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Yeah, openSSI approach has some advantages, but how about the other side,
> how are the devices and files being handled?  isn't it wrong to run
> someone elses process when the data that he is supposed to provide is
> missing?  My work is based on a workstation model where all the nodes are
> independent workstations (in most cases with similar configurations, as in
> a computer laboratory at a university).  One of my major constraints is
> that the system should be binary compatible with the kernel that does not
> support my model. In my case i plan packing and restarting a process when
> the creation node goes down.
> 
> Prasad.
> 

Missed something in my previous one... even i am migrating only part of 
the system mode computations on the creation node. They only include the 
device/filesystem handling syscalls.  Most of the other things, that 
correspond to the process and memory management are being executed on the 
host system itself.

Prasad.

-- 
Failure is not an option

