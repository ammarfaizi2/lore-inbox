Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292938AbSCORGD>; Fri, 15 Mar 2002 12:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292931AbSCORFx>; Fri, 15 Mar 2002 12:05:53 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:12872 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S292938AbSCORFg>; Fri, 15 Mar 2002 12:05:36 -0500
Date: Fri, 15 Mar 2002 12:05:21 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux390@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Patch to fix s390 cross-compilation in 2.4.18
Message-ID: <20020315120521.A4262@devserv.devel.redhat.com>
In-Reply-To: <20020311022529.A29248@devserv.devel.redhat.com> <28920.1015834086@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <28920.1015834086@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Mon, Mar 11, 2002 at 07:08:06PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Keith Owens <kaos@ocs.com.au>
> Date: Mon, 11 Mar 2002 19:08:06 +1100

> >The s390 cannot be cross-compiled, because necessary -I is missing
> >from gcc flags of assembler modules. Also I straightened flags up
> >a little bit (removed duplicated -D__ASSEMBLY__).
> 
> Looks good.  Could you try without -traditional?  I want to know if
> that flag is really required or not.

It is required, because without it cpp blows up on assembler comments
with special characters in them.

Martin, did you apply the patch?

-- Pete
