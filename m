Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbSJWFxJ>; Wed, 23 Oct 2002 01:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSJWFxJ>; Wed, 23 Oct 2002 01:53:09 -0400
Received: from franka.aracnet.com ([216.99.193.44]:20412 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262876AbSJWFxJ>; Wed, 23 Oct 2002 01:53:09 -0400
Date: Tue, 22 Oct 2002 22:57:14 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: New panic (io-apic / timer?) going from 2.5.44 to 2.5.44-mm1
Message-ID: <2715941567.1035327433@[10.10.2.3]>
In-Reply-To: <3DB5EDEF.59A27A9A@digeo.com>
References: <3DB5EDEF.59A27A9A@digeo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Is possibly the code which defers the allocation of the per-cpu
>> > memory until the secondary processors are being brought online.
>> 
>> Aha ... ;-) thanks for the pointer. Will poke at that.

Humpf. Well I tried -mm3 (after backing out Rusty's patch), and
it still has the problem ;-( Must be something else.
 
> The kgdb code plays around at that level too.  A patch -R of
> kgdb.patch would be interesting.

OK ... will try that then brute force and ignorance (binary chop
search) I guess.

M.

