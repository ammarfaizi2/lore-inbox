Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVGMMKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVGMMKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 08:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVGMMKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 08:10:35 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:52916 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262795AbVGMMKc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 08:10:32 -0400
Date: Wed, 13 Jul 2005 14:13:13 +0200
From: DervishD <lkml@dervishd.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Konstantin Kudin <konstantin_kudin@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: fdisk: What do plus signs after "Blocks" mean?
Message-ID: <20050713121313.GB58@DervishD>
Mail-Followup-To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Konstantin Kudin <konstantin_kudin@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20050712173721.GA325@DervishD> <200507122019.j6CKJwxe021850@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200507122019.j6CKJwxe021850@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Horst :)

 * Horst von Brand <vonbrand@inf.utfsm.cl> dixit:
> DervishD <lkml@dervishd.net> wrote:
> >     It's a good idea to have a copy of the partition table around, if
> > it is not simple (the one you had is NOT simple).
> Be careful. What you'll get out of backing up the partition table is /only/
> the primary partitions, the others are handled by a weird russian doll of
> partitions-inside-partitions. AFAIR, the details were in the LILO docu.

    Note that I didn't suggest to backup or have a copy of the MBR,
but of the partition table, the FULL partition table (that includes
the secondary partitions and the like. Once a disk is fully
partitioned, a couple of 'dd' commands do the trick even for
extended partitions.

    It's a mess, anyway :( 

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
