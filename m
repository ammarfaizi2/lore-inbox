Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSEHFdS>; Wed, 8 May 2002 01:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315530AbSEHFdR>; Wed, 8 May 2002 01:33:17 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:457 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S315529AbSEHFdQ>;
	Wed, 8 May 2002 01:33:16 -0400
Date: Tue, 07 May 2002 22:33:24 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Robert Love <rml@tech9.net>, Clifford White <ctwhite@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86 question: Can a process have > 3GB memory?
Message-ID: <157212850.1020810803@[10.10.2.3]>
In-Reply-To: <1020812936.2079.31.camel@bigsur>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can go to 3.5GB, anything more and stuff starts getting real tight
> and not very nice.  You can only do 3.5/0.5 on non-PAE, though - PAE
> requires segments to be aligned on 1GB-boundaries.
> 
> The attached patch (for which credit goes elsewhere - Ingo or Randy, I
> think?) implements the full range of 1 to 3.5GB user space partitioning,
> selectable at compile-time.

The trouble with this is that on a machine with enough memory to
make it worthwhile, it normally just runs you out of zone_normal
instead ;-(

M.

