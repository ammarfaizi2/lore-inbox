Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUCZAni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbUCZAgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:36:14 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:50078 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S263876AbUCZAS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:18:26 -0500
Subject: Re: Binary-only firmware covered by the GPL?
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, 239952@bugs.debian.org,
       debian-devel@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <40635DD9.8090809@pobox.com>
References: <E1B6Izr-0002Ai-00@r063144.stusta.swh.mhn.de>
	 <20040325082949.GA3376@gondor.apana.org.au>
	 <20040325220803.GZ16746@fs.tum.de>  <40635DD9.8090809@pobox.com>
Content-Type: text/plain
Message-Id: <1080260235.3643.103.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Fri, 26 Mar 2004 00:17:15 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-25 at 17:31 -0500, Jeff Garzik wrote:
> Firmware is a program that executes on another processor, so no linking 
> is taking place at all.  It is analagous to shipping a binary-only 
> program in your initrd, IMO.

You seem to be thinking of this:

  These requirements apply to the modified work as a whole.  If
  identifiable sections of that work are not derived from the Program,
  and can be reasonably considered independent and separate works in
  themselves, then this License, and its terms, do not apply to those
  sections... 

But you seem to ignore the fact that the sentence ends thus:

        ...WHEN YOU DISTRIBUTE THEM AS SEPARATE WORKS.

And indeed that the subsequent sentence reads as follows:

                                                        But when you
  distribute the same sections as part of a whole which is a work based
  on the Program, the distribution of the whole must be on the terms of
  this License, whose permissions for other licensees extend to the
  entire whole, and thus to each and every part regardless of who wrote
  it.

You also seem to be ignoring the next paragraph where it mentions
COLLECTIVE works:

  Thus, it is not the intent of this section to claim rights or contest
  your rights to work written entirely by you; rather, the intent is to
  exercise the right to control the distribution of derivative OR
  COLLECTIVE WORKS based on the Program.

------

The firmware blob in question can be reasonably considered to be an
independent and separate work in itself. The GPL doesn't apply to it
when it is distributed as a SEPARATE work. But when you distribute it as
part of a whole which is a work based on other parts of the kernel, by
including it in the kernel source in such a manner, the distribution of
the whole must be on the terms of the GPL, whose permissions for other
licensees extend to the entire whole, and thus to each and every part.

It's not the intent of the GPL to claim rights to firmware written
independently for such hardware; rather, the intent is to exercise the
right to control the distribution of _COLLECTIVE_ works based on the
indisputably GPL'd parts of the kernel.

-- 
dwmw2


