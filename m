Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbTLKPjh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbTLKPjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:39:37 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:36147 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265132AbTLKPjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:39:35 -0500
Date: Thu, 11 Dec 2003 15:39:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
cc: dual_bereta_r0x@arenanetwork.com.br, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23 + tmpfs: where's my mem?!
In-Reply-To: <bra0rj$qai$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.44.0312111535400.1454-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Mario 'BitKoenig' Holbe wrote:
> > Hugh Dickins <hugh@veritas.com> writes:
> >> But the strange thing is that df's Used does not match du: they should
> >> be identical, though arrived at from different directions.  I've not
> 
> No, they are not identical and should not be.
> 
> Unlike df, which reads the used counter from the filesystem
> meta information, du iterates over files within directories.
> 
> If you have a file without a name (created, still open, all
> links removed), it does not exist in any directory but it
> does exist in the filesystem. So df should show the space
> used for it, while du should not.

Yes, of course, you and Willy are right, and the only mystery is
how I could make a mystery of it while already knowing what you've
explained well here.  Thanks!

Hugh

