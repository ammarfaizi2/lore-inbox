Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318702AbSHAK75>; Thu, 1 Aug 2002 06:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318703AbSHAK75>; Thu, 1 Aug 2002 06:59:57 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:35290 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S318702AbSHAK74>;
	Thu, 1 Aug 2002 06:59:56 -0400
Date: Thu, 1 Aug 2002 13:03:23 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200208011103.NAA01989@harpo.it.uu.se>
To: neilb@cse.unsw.edu.au
Subject: NFS ACL compatibility [was: Re: [2.6] The List, pass #2]
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2002 10:34:23 +1000 (EST), Neil Brown wrote: 
>Well, given that the protocol specification isn't 100% finalised, it's
>not clear that pushing for inclusion now is entirely sensible.  We
>don't want people to be using an NFSv4 on Linux that is incompatible
>in some subtle way with other vendors.
>
>Also, I suspect that NFSv4 will be fairly localised in the changes it
>makes and could well go in to 2.6.10 of whatever (afterall, reiserfs
>went in at 2.4.2).
>
>There are some changes that NFSv4 would like to make that affect
>common code, such as making open(,O_EXCL) work for a networked
>filesystem, but we can live without that (as we do with NFSv3), but
>hopefully that functionality will get in before halloween anyway. 

Speaking of NFS compatibility: can Linux' NFS server implement ACLs
in a way that's compatible with Solaris NFS clients?

A sysadmin over here says this isn't the case, because Sun apparently
stepped outside of the NFSv3 protocol and handles ACLs with a
separate RPC program.

The significance of this is that unless Linux' NFS server can be made
fully compatible with Solaris NFS clients, we can't use Linux for the
new high-performance NFS servers we need to install this fall, forcing
us to go with Solaris and fairly expensive Sun HW.

/Mikael
