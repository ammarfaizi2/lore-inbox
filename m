Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266091AbTGISlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266078AbTGISlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:41:50 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:27654 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S266091AbTGISl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:41:28 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: trond.myklebust@fys.uio.no
Subject: Re: ->direct_IO API change in current 2.4 BK
Date: Wed, 9 Jul 2003 20:55:41 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
References: <20030709133109.A23587@infradead.org> <200307092041.42608.m.c.p@wolk-project.de> <16140.25619.963866.474510@charged.uio.no>
In-Reply-To: <16140.25619.963866.474510@charged.uio.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307092055.41863.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 July 2003 20:50, Trond Myklebust wrote:

Hi Trond,

> So they have both XFS + NFS O_DIRECT?
yes.

> The answer to your question is then that somebody made the trivial
> conversion on XFS... It's just a question of replacing the second
> argument of the direct_IO() method with a filp, then extracting the
> inode from that. A 2-liner patch at most...
EXACT! That was my intention with my small first post ;)

> The point here is that Marcelo's tree does not include XFS, so my
> patch can't fix it up...
> As I said, I suggest replacing KERNEL_HAS_O_DIRECT with
> KERNEL_HAS_O_DIRECT2 so that the XFS patches can switch on that, and
> hence provide the 2-liner on newer kernels...
It's very okay with me.

ciao, Marc

