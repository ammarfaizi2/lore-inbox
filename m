Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWJHSyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWJHSyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWJHSyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:54:13 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:20661 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751338AbWJHSyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:54:12 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG when doing parallel NFS mounts (WAS: Re: Merge window closed: v2.6.19-rc1)
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	<m37izbhvvb.fsf@telia.com> <m3mz86hm39.fsf@telia.com>
	<1160332545.11233.3.camel@lade.trondhjem.org>
From: Peter Osterlund <petero2@telia.com>
Date: 08 Oct 2006 20:54:09 +0200
In-Reply-To: <1160332545.11233.3.camel@lade.trondhjem.org>
Message-ID: <m31wpihc4u.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> On Sun, 2006-10-08 at 17:19 +0200, Peter Osterlund wrote:
> > > kernel BUG at fs/nfs/client.c:352!
> 
> Does the following patch fix it?

Yes it does. Thanks!

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
