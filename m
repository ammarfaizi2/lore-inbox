Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267735AbTADATv>; Fri, 3 Jan 2003 19:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267731AbTADATv>; Fri, 3 Jan 2003 19:19:51 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:29454 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S267724AbTADATu>; Fri, 3 Jan 2003 19:19:50 -0500
Date: Sat, 4 Jan 2003 11:28:12 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "BODA Karoly jr." <woockie@expressz.com>
cc: sparclinux@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.54-sparc64 compile errors
In-Reply-To: <Pine.LNX.3.96.1030103194702.7821A-100000@ligur.expressz.com>
Message-ID: <Mutt.LNX.4.44.0301041126480.19977-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2003, BODA Karoly jr. wrote:

> 	After booting I can't insmod (even with insmod nor with modprobe)
> anything with the following error message:
> 
> mortimer:~# modprobe nfs
> WARNING: Error inserting sunrpc (/lib/modules/2.5.54/kernel/net/sunrpc/sunrpc.ko): Cannot allocate memory
> WARNING: Error inserting lockd (/lib/modules/2.5.54/kernel/fs/lockd/lockd.ko): Cannot allocate memory
> FATAL: Error inserting nfs (/lib/modules/2.5.54/kernel/fs/nfs/nfs.ko): Cannot allocate memory
> 

Try Rusty's sh_link patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=104157163822921&w=2



- James
-- 
James Morris
<jmorris@intercode.com.au>


