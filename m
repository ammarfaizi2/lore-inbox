Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbTB0VC6>; Thu, 27 Feb 2003 16:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbTB0VC6>; Thu, 27 Feb 2003 16:02:58 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:9222 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S267029AbTB0VC5>; Thu, 27 Feb 2003 16:02:57 -0500
Date: Thu, 27 Feb 2003 16:12:56 -0500
From: Ben Collins <bcollins@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       ak@suse.de, arnd@bergmann-dalldorf.de
Subject: Re: ioctl32 consolidation -- call for testing
Message-ID: <20030227211256.GR21100@phunnypharm.org>
References: <20030227203440.GP21100@phunnypharm.org> <20030227.122126.30208201.davem@redhat.com> <20030227205044.GQ21100@phunnypharm.org> <20030227.123701.16257819.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030227.123701.16257819.davem@redhat.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 12:37:01PM -0800, David S. Miller wrote:
>    From: Ben Collins <bcollins@debian.org>
>    Date: Thu, 27 Feb 2003 15:50:44 -0500
> 
>    On Thu, Feb 27, 2003 at 12:21:26PM -0800, David S. Miller wrote:
>    > Well, you just doubled the size of the table on sparc64.
>    > I don't know if I like that.
>    
>    Not much of a way around it.
> 
> Such problems are only in your mind. :-)
> 
> What's wrong with defining the type and accessor macros
> in include/asm/compat.h?

One thing I am just now wondering is why struct ioctl_trans defines cmd
as an unsigned long instead of just unsigned int. That adds an uneeded
bit of space to the array.

As for your suggestion, sounds great, but I'll leave it to Pavel :)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
