Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129656AbRBTRqG>; Tue, 20 Feb 2001 12:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129986AbRBTRp5>; Tue, 20 Feb 2001 12:45:57 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:18926
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S129656AbRBTRpn>; Tue, 20 Feb 2001 12:45:43 -0500
Date: Tue, 20 Feb 2001 10:44:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ben LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [PATCH] make nfsroot accept server addresses from BOOTP root
Message-ID: <20010220104415.D3150@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.30.0102191809350.27085-100000@today.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.30.0102191809350.27085-100000@today.toronto.redhat.com>; from bcrl@redhat.com on Mon, Feb 19, 2001 at 06:12:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2001 at 06:12:12PM -0500, Ben LaHaise wrote:

> Here's a handy little patch that makes the kernel parse out the ip
> address of the nfs server from the bootp root path.  Otherwise it's
> impossible to boot the kernel without command line options on diskless
> workstations (I hate RPL).

Er, say that again?  Right now, for bootp if you specify "sa=xxx.xxx.xxx.xxx"
Linux uses that as the host for the NFS server (which does have the side
effect of if TFTP server != NFS server, you don't boot).  Are you saying
your patch takes "rp=xxx.xxx.xxx.xxx:/foo/root" ?  Just curious, since I
don't know, whats the RFC say about this?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
