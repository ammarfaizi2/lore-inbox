Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273965AbRIRXfz>; Tue, 18 Sep 2001 19:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273968AbRIRXfp>; Tue, 18 Sep 2001 19:35:45 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:5132 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S273965AbRIRXfb>; Tue, 18 Sep 2001 19:35:31 -0400
Date: Tue, 18 Sep 2001 19:35:41 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: "Eric W. Biederman" <ebiederman@lnxi.com>
cc: Ronald G Minnich <rminnich@lanl.gov>, linux-kernel@vger.kernel.org
Subject: Re: LinuxBIOS + ASUS CUA + 2.4.5 works; with 2.4.6 locks up
In-Reply-To: <m3u1y0kspb.fsf@DLT.linuxnetworx.com>
Message-ID: <Pine.LNX.4.10.10109181931570.2275-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is hard to call.  The most interesting case I know of is the VIA kt133
> AMD bug.  I believe it is register 0x55 bit 7 that when set causes an
> athlon optimized memcpy to crash the machine, but when clear it works.

"causes" is a bit strong - there are plenty of machines where it 
most definitely doesn't effect stability at all.  that is, kt133a
machines which use Arjan's fast_copy_page without any problem,
and yet have 0x55:7 set.  (my A7V133's is 0x89, for instance.)

