Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbTDGUYA (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbTDGUYA (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:24:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61713 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263686AbTDGUX7 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 16:23:59 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new syscall: flink
Date: 7 Apr 2003 13:35:12 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6sne0$jad$1@cesium.transmeta.com>
References: <20030407165009.13596.qmail@email.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030407165009.13596.qmail@email.com>
By author:    "Clayton Weaver" <cgweav@email.com>
In newsgroup: linux.dev.kernel
> 
> Since the client owns the new directory entry, it can chmod the
> inode to have any permissions it wants, create or modify an ACL
> where ACLs are in use, modify a capabilities mask more fine-grained
> than traditional unix permissions if something like that is in use,
> etc.
> 

Uhm, no.  Ownership is an inode property.

     -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
