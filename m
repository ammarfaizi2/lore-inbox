Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317438AbSFHTzV>; Sat, 8 Jun 2002 15:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317439AbSFHTzU>; Sat, 8 Jun 2002 15:55:20 -0400
Received: from ns.suse.de ([213.95.15.193]:3852 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317438AbSFHTzT>;
	Sat, 8 Jun 2002 15:55:19 -0400
Date: Sat, 8 Jun 2002 21:55:20 +0200
From: Dave Jones <davej@suse.de>
To: jay <jbeatty@optonline.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: rpm --rebuild fails on 2.5.20
Message-ID: <20020608215520.D13140@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	jay <jbeatty@optonline.net>,
	linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D0249AE.4070902@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2002 at 02:15:10PM -0400, jay wrote:
 > When I try to use rpm to rebuild a src.rpm, it gives a Segmentation 
 > fault on 2.5.20. Works on 2.5.18 and 2.4.18.
 > 
 > rpm -vvvvvv --rebuild ORBit2*
 > Segmentation fault
 > Some small src.rpm files work, e.g. filesystem-2.1.6-4.src.rpm, but not all.

can you strace an operation that fails, and find out where it's
segfaulting.  Also, check dmesg for a kernel oops, and decode
with kysmoops if present.

I've one other report of a problem with capabilities, which
might be related.

        Dave 

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
