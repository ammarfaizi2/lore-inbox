Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272402AbRH3Sv7>; Thu, 30 Aug 2001 14:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272403AbRH3Svs>; Thu, 30 Aug 2001 14:51:48 -0400
Received: from THANK.THUNK.ORG ([216.175.175.163]:37252 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S272402AbRH3Svk>;
	Thu, 30 Aug 2001 14:51:40 -0400
Date: Thu, 30 Aug 2001 14:51:55 -0400
From: Theodore Tso <tytso@mit.edu>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Michael E Brown <michael_e_brown@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blkgetsize64 ioctl
Message-ID: <20010830145155.A3114@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Ben LaHaise <bcrl@redhat.com>,
	Michael E Brown <michael_e_brown@dell.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108301150460.1213-100000@blap.linuxdev.us.dell.com> <Pine.LNX.4.33.0108301306300.12593-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0108301306300.12593-100000@toomuch.toronto.redhat.com>; from bcrl@redhat.com on Thu, Aug 30, 2001 at 01:12:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 01:12:07PM -0400, Ben LaHaise wrote:
> 
> No, that's not what's got me miffed.  What is a problem here is that an
> obvious next to use ioctl number in a *CORE* kernel api was used without
> reserving it.  AND PEOPLE SHIPPED IT!  I for one don't go about shipping
> new ABIs without reserving at least a placeholder for it in the main
> kernel (or stating that the code is not bearing a fixed ABI).  If the
> ioctl # was in the main kernel, this mess would never have happened even
> with the accidental shipping of the patch in e2fsprogs.  

... and for my part, I included the patch in e2fsprogs because Ben
sent me the patch, saying that people would want to test it, and I
assumed he had already reserved the ioctl in the kernel.  I should
have checked first....

							- Ted
