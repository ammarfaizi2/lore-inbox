Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288540AbSADIHf>; Fri, 4 Jan 2002 03:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288538AbSADIHU>; Fri, 4 Jan 2002 03:07:20 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:46908 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S288534AbSADIGR>; Fri, 4 Jan 2002 03:06:17 -0500
Date: Fri, 4 Jan 2002 10:06:05 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Ken Brownfield <brownfld@irridia.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020104100604.D1331@niksula.cs.hut.fi>
In-Reply-To: <20020103142301.C4759@asooo.flowerfire.com> <200201040019.BAA30736@webserver.ithnet.com> <20020103232601.B12884@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020103232601.B12884@asooo.flowerfire.com>; from brownfld@irridia.com on Thu, Jan 03, 2002 at 11:26:01PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 11:26:01PM -0600, you [Ken Brownfield] claimed:
> 
> | > 3) Memory allocation failures and OOM triggers                      
> | >    even though caches remain full.                                  
> |                                                                       
> | I have not had one up to now in everyday life with 2.4.17             
> 
> I'm seeing this in malloc()-heavy apps, but fairly sporadic unless I
> create a test case.  

I'm seeing this on 2GB IA64 (2.4.16-17). I posted a _very_ simple test case
to lkml a while a go. It didn't happen on 256MB x86.

I plan to try -aa shortly, now that I got patches to make it compile on
IA64.


-- v --

v@iki.fi
