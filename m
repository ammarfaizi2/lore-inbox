Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135287AbRAJMrf>; Wed, 10 Jan 2001 07:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135276AbRAJMr0>; Wed, 10 Jan 2001 07:47:26 -0500
Received: from cr949225-b.rchrd1.on.wave.home.com ([24.112.58.97]:26124 "HELO
	enfusion-group.com") by vger.kernel.org with SMTP
	id <S131369AbRAJMrW>; Wed, 10 Jan 2001 07:47:22 -0500
Date: Wed, 10 Jan 2001 07:36:10 -0500
From: Adrian Chung <adrian@enfusion-group.com>
To: linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 bug in SHM an via-rhine or is it my fault?
Message-ID: <20010110073610.A1582@toad.enfusion-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109143016.A15225@rogue.enfusion-group.com>; from adrian@enfusion-group.com on Tue, Jan 09, 2001 at 02:30:16PM -0500
Organization: enfusion-group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 02:30:16PM -0500, Adrian Chung wrote:
> NFS from the client system (Duron - 2.4.0-ac4), hangs almost
> immediately when trying to contact a 2.2.18 NFS server.  I get "nfs
> can't get task slot" errors, and "NFS server xxx.xxx.xxx.xxx not
> responding", especially after doing a "dd if=/dev/zero
> of=/home/user/nfstest bs=16k count=4096".  After checking, the file
> /home/user/nfstest is 8192 bytes big.  The client mount is a default
> NFS mount, with no rsize/wsize parameters.

I forced the module to load with options "full_duplex=1" and the card
now seems to work fine.  NFS transfers work perfectly at least.

--
Adrian Chung
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
