Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289145AbSAJDzd>; Wed, 9 Jan 2002 22:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289146AbSAJDzZ>; Wed, 9 Jan 2002 22:55:25 -0500
Received: from void.printf.net ([213.253.1.202]:19723 "EHLO void")
	by vger.kernel.org with ESMTP id <S289145AbSAJDzO>;
	Wed, 9 Jan 2002 22:55:14 -0500
Date: Thu, 10 Jan 2002 04:03:09 +0000
From: Chris Ball <chris@void.printf.net>
To: Benjamin S Carrell <ben@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bigggg Maxtor drives (fwd)
Message-ID: <20020110040308.A28692@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3D0718.2060602@xmission.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 08:14:32PM -0700, Benjamin S Carrell wrote:
> I would think that you lose that space to formatting

That would be irrelevant.  We're looking at the kernel's summation of
the geometry, not the filesystem's description of usable space.

> (would it not get the size of the drive from the bios?)

No, the kernel tends not to rely on the BIOS for geometry.  Which is
usually very wise.

> but I stand open for correction.

Same here.  It's always a good idea.  :-)

Is this perhaps Maxtor providing their own 'non-standard'[1] definition
of gigabyte, rather than a technical issue?

- Chris.

[1]: (viz. 'wrong')
-- 
$a="printf.net"; Chris Ball | chris@void.$a | www.$a | finger: chris@$a
As to luck, there's the old miners' proverb: Gold is where you find it.
