Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262704AbTDBUuy>; Wed, 2 Apr 2003 15:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262961AbTDBUux>; Wed, 2 Apr 2003 15:50:53 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:7480 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262704AbTDBUut> convert rfc822-to-8bit; Wed, 2 Apr 2003 15:50:49 -0500
Date: Wed, 2 Apr 2003 22:04:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Christoph Rohland <cr@sap.com>, CaT <cat@zip.com.au>, <tomlins@cam.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
In-Reply-To: <20030402204450.GB17890@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0304022201010.3034-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Jörn Engel wrote:
> On Wed, 2 April 2003 19:33:05 +0200, Christoph Rohland wrote:
> > 
> > No, that's why I said you would need hooks into swapon and
> > swapoff. Then it would adjust on the fly. Else it's useless from the
> > usability point of view. With these hooks it's easy to do.
> 
> Can you show me the easy part with this setup?
> 256MB RAM
> 512MB swap
> 50% tmpfs (384MB)
> fill tmpfs completely
> swapoff -a

Don't blame Christoph for that, one of these days I'll face up to
my responsibilities and make swapoff fail (probably get itself
OOM-killed) instead of having everything else OOM-killed.

Hugh

