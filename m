Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261937AbTCaXrh>; Mon, 31 Mar 2003 18:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261941AbTCaXrh>; Mon, 31 Mar 2003 18:47:37 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:12938 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S261937AbTCaXrf>; Mon, 31 Mar 2003 18:47:35 -0500
Date: Mon, 31 Mar 2003 15:55:44 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030331235544.GS32000@ca-server1.us.oracle.com>
References: <200303311541.50200.pbadari@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303311541.50200.pbadari@us.ibm.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 03:41:50PM -0800, Badari Pulavarty wrote:
> I have been playing with supporting 4000 disks on IA32 machines.
> There are bunch of issues we need to resolve before we could
> do that.

	That's the conversation I'm trying to kickstart.

> I am using scsi_debug to simulate 4000 disks. (Ofcourse, I had
> to hack "sd" to support more than 256 disks). Anyway, I noticed
> that I lost almost 350MB of my lowmem, when I simulated 4000 disks.
> We are working on most of these. But there are userlevel issues
> to be resolved. Here is the list ...

	Wow, this is cool.  Thanks for telling me about this.

> I have not done any IO on these yet. When I mount all of these and do
> IO on them, we might see new issues. So with all these, I will be doubtful
> if we can ever reach 16k disks on IA32.

	We're going to have to find a way.  IA32 is going to be around
for long enough, I think.  Easily 8k disks, as soon as the folks who are
doing 4k disks today want to multipath.

Joel

-- 

Life's Little Instruction Book #226

	"When someone hugs you, let them be the first to let go."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
