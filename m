Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135531AbRDXKqv>; Tue, 24 Apr 2001 06:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135532AbRDXKq3>; Tue, 24 Apr 2001 06:46:29 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:37716 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135531AbRDXKq2>; Tue, 24 Apr 2001 06:46:28 -0400
Date: Tue, 24 Apr 2001 12:46:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rwsem benchmark [was Re: [PATCH] rw_semaphores, optimisations try #3]
Message-ID: <20010424124621.D1682@athlon.random>
In-Reply-To: <20010424121747.A1682@athlon.random> <6252.988108393@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6252.988108393@warthog.cambridge.redhat.com>; from dhowells@warthog.cambridge.redhat.com on Tue, Apr 24, 2001 at 11:33:13AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 11:33:13AM +0100, David Howells wrote:
> *grin* Fun ain't it... Try it on a dual athlon or P4 and the answer may come
> out differently.

compile with -mathlon and the compiler then should generate (%%eax) if that's
faster even if the sem is a constant, that's a compiler issue IMHO, I just give the
compiler the flexibility to do the right choice.

Andrea
