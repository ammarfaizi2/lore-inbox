Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266574AbRGJPHF>; Tue, 10 Jul 2001 11:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266544AbRGJPGz>; Tue, 10 Jul 2001 11:06:55 -0400
Received: from ECE.CMU.EDU ([128.2.236.200]:60288 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S266520AbRGJPGk>;
	Tue, 10 Jul 2001 11:06:40 -0400
Date: Tue, 10 Jul 2001 11:06:35 -0400 (EDT)
From: Craig Soules <soules@happyplace.pdl.cmu.edu>
To: "J. Richard Sladkey" <jrs@foliage.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: RE: NFS Client patch
In-Reply-To: <MOBBLAGBDIJIPKLCBNCNGELFEBAA.jrs@foliage.com>
Message-ID: <Pine.LNX.3.96L.1010710110442.16113T-100000@happyplace.pdl.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2001, J. Richard Sladkey wrote:
> This interpretation isn't useful.  If a second client modifies the
> directory while the first client is reading a directory, the first
> client has no way of knowing that its cookie is now invalid, yet it
> clearly will be invalid if the server's cookies are invalid after
> any directory modifying operation.

I believe that the behavior in this case is still undetermanistic.  More 
generically, if one person is writing to a file and another is reading, it
is unclear what that person will get at all.

Craig

