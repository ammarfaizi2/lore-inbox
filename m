Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTCKR71>; Tue, 11 Mar 2003 12:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbTCKR71>; Tue, 11 Mar 2003 12:59:27 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:50879 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S261495AbTCKR70>; Tue, 11 Mar 2003 12:59:26 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 11 Mar 2003 19:12:40 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Michael Hunold <m.hunold@gmx.de>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l: create include/media.
Message-ID: <20030311181240.GB7186@bytesex.org>
References: <20030310200852.GA6397@bytesex.org> <20030310220233.A13923@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310220233.A13923@infradead.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 10:02:33PM +0000, Christoph Hellwig wrote:
> > +#define MIN(a,b) (((a)>(b))?(b):(a))
> > +#define MAX(a,b) (((a)>(b))?(a):(b))
> 
> Don't do that.  Use the kernel's min/max instead.

Yea, I've noticed that too while reviewing the patch, deleted them
(and fixed the code which uses them).  But then somehow managed to
mail the old patch version :-/  I'll resort stuff and mail a new
patch later today or tomorrow.

  Gerd

-- 
/join #zonenkinder
