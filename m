Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290776AbSAYSnf>; Fri, 25 Jan 2002 13:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290783AbSAYSnV>; Fri, 25 Jan 2002 13:43:21 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:17932 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290776AbSAYSnF>; Fri, 25 Jan 2002 13:43:05 -0500
Date: Fri, 25 Jan 2002 13:42:48 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Rainer Krienke <krienke@uni-koblenz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Message-ID: <20020125134248.B16106@devserv.devel.redhat.com>
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <200201240858.g0O8wnH03603@bliss.uni-koblenz.de> <20020124121649.A7722@devserv.devel.redhat.com> <200201250728.g0P7SDH26738@bliss.uni-koblenz.de> <20020125124110.A357@devserv.devel.redhat.com> <200201251834.g0PIYxj02545@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201251834.g0PIYxj02545@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Fri, Jan 25, 2002 at 11:34:59AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 25 Jan 2002 11:34:59 -0700
> From: Richard Gooch <rgooch@ras.ucalgary.ca>

> The allocation function should be safe, since it only gives majors
> which are not assigned in devices.txt. [...]

Oh, that changes it, I should have looked closer.
I am not sure the "1200 NFS mounts" case warrants the
change though, so far we have only one active user (Rainer) :)
If ISPs and universities clamour for my patch, then sure,
we may improve it with devfs_alloc_major() in 2.4, too.
Otherwise, whatever... Thanks for the explanation, Richard,
I'll keep it in my notes.

-- Pete
