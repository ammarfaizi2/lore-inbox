Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268272AbTBMTVn>; Thu, 13 Feb 2003 14:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268273AbTBMTVn>; Thu, 13 Feb 2003 14:21:43 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:39069 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268272AbTBMTVm>;
	Thu, 13 Feb 2003 14:21:42 -0500
Date: Thu, 13 Feb 2003 19:27:14 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Joel Becker <Joel.Becker@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 NFS FSX
Message-ID: <20030213192714.GB11244@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Joel Becker <Joel.Becker@oracle.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030213152742.GA1560@codemonkey.org.uk> <20030213185410.GN20972@ca-server1.us.oracle.com> <shsd6lwati2.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shsd6lwati2.fsf@charged.uio.no>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 08:08:21PM +0100, Trond Myklebust wrote:

 > Does either you have a tcpdump you could send me of one of the above
 > events? Use a large snaplen since we want to check the readdir reply
 > length (which tends to be ~4k). Something like
 > 
 >    tcpdump -s 8192 -w dump.out host blah and port 2049

Not easily. I'm trying to get an exact reproduction case
(fsx does it 'sometimes').  So far the best I've been able
to get is a 164MB dump file. As soon as I narrow it down
and get a sensible dump size, I'll let you know.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
