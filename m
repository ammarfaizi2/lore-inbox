Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262815AbSJWECF>; Wed, 23 Oct 2002 00:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbSJWECF>; Wed, 23 Oct 2002 00:02:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18447 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262815AbSJWECE>; Wed, 23 Oct 2002 00:02:04 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] linux-2.5.44_vsyscall_A1
Date: 22 Oct 2002 21:08:08 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ap57b8$2go$1@cesium.transmeta.com>
References: <1035336629.954.90.camel@cog> <3DB60363.8040104@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3DB60363.8040104@pobox.com>
By author:    Jeff Garzik <jgarzik@pobox.com>
In newsgroup: linux.dev.kernel
> 
> In terms of implementation, I think it's way too x86-specific...  some 
> of the vsyscall infrastructure can be more generic, making it easier for 
> other arches to implement the same functionality.  Also use of TSC isn't 
> a terribly good idea...
> 

Sure it is: on the systems which have a working TSC it is extremely
efficient -- cheap and high precision.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
