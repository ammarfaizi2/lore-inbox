Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292332AbSBPJjO>; Sat, 16 Feb 2002 04:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292333AbSBPJjF>; Sat, 16 Feb 2002 04:39:05 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:14229 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S292332AbSBPJjA>; Sat, 16 Feb 2002 04:39:00 -0500
Date: Sat, 16 Feb 2002 11:29:38 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Robert Love <rml@tech9.net>, Robert Jameson <rj@open-net.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Hard lockup with 2.4.18-pre9 + preempt + lock break + O1k[23]
 + rmap
In-Reply-To: <20020215201810.GA5310@matchmail.com>
Message-ID: <Pine.LNX.4.44.0202161123530.18770-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2002, Mike Fedyk wrote:

> I don't use USB, and I have had several machines lock up hard while doing
> medium to heavy IO.  I've had this happen with pre9-mjc2 and another patch
> that just contained pre9-preempt-schedo1
> (nyu.dyn.dhs.org:8080/patches/2.4.18-pre9-to-rmap12e-schedO1-rml.patch.bz2)
> 
> I'm running 2.4.18-pre9-ac3 now to see if I can reproduce without prempt and
> O(1).

I run the same configuration here but UP, with quite a bit of I/O, box 
NFS exports a large build directory to 2 other boxes plus usually has 2 
builds going locally as well as being used as a storage area for 
creating isos/burning cds. VM load is medium for a 512mem/512swap box, 
~140 processes and ~150megs into swap.

Cheers,
	Zwane Mwaikambo



