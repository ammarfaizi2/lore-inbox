Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTAUFdS>; Tue, 21 Jan 2003 00:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbTAUFdS>; Tue, 21 Jan 2003 00:33:18 -0500
Received: from rth.ninka.net ([216.101.162.244]:22938 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261907AbTAUFdR>;
	Tue, 21 Jan 2003 00:33:17 -0500
Subject: Re: Minor header bug? MIPS (32-bit) nlink_t sign
From: "David S. Miller" <davem@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jamie Lokier <jamie@shareable.org>, ralf@gnu.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030121160959.6e392885.sfr@canb.auug.org.au>
References: <20030118033435.GC18282@bjl1.asuk.net> 
	<20030121160959.6e392885.sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Jan 2003 22:18:47 -0800
Message-Id: <1043129927.16172.1.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-20 at 21:09, Stephen Rothwell wrote:
> On Sat, 18 Jan 2003 03:34:35 +0000 Jamie Lokier <jamie@shareable.org> wrote:
> >
> > Stephen, I guess you have already figured this out with your recent
> > 32-bit compatibility cleanup?
> 
> I mainly did direct substitutions, but will have a look shortly and see
> what I think.
> 
> I assume we are being compatable with Irix? Ralf?

nlink_t is a signed short on sparc32 as well, and yes this is to
be compatible with SunOS

