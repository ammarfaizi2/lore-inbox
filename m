Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTFOSAd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTFOSAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:00:33 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:55475 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262489AbTFOSAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:00:32 -0400
Date: Sun, 15 Jun 2003 20:14:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Brian Jackson <brian@mdrx.com>, Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030615181424.GJ1063@wohnheim.fh-wedel.de>
References: <20030615160524.GD1063@wohnheim.fh-wedel.de> <20030615182642.A19479@infradead.org> <20030615173926.GH1063@wohnheim.fh-wedel.de> <20030615184417.A19712@infradead.org> <20030615175815.GI1063@wohnheim.fh-wedel.de> <20030615190349.A21931@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030615190349.A21931@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 June 2003 19:03:49 +0100, Christoph Hellwig wrote:
> On Sun, Jun 15, 2003 at 07:58:15PM +0200, Jörn Engel wrote:
> > Ok, you win this one.  Leaves this case:
> > $ mount /dev/somewhere /mnt
> > cramfs: wrong magic
> > $ echo $?
> > 0
> > $
> 
> Umm, please explain.  You got a sucessfull mount of a non-cramfs
> filesystem type but an error from cramfs?  What version of mount
> do you use?

Actually, that is what I expect to get tomorrow, when I have access to
hardware and can verify it.

> It's not a debug printk.  Please leave the messages in, it's really
> helpful to see what failed when mount doesn't succeed.

Yes, I agree.  It is any the "Cramfs didn't find it's magic number,
now we'll try another filesystem instead. Usually this should be
harmless and you can safely ignore this message." that bothers me,
because the current wording sounds more like "Something terrible has
happened, go and find someone to bug with this."

What do you propose instead?

Jörn

-- 
Everything should be made as simple as possible, but not simpler.
-- Albert Einstein
