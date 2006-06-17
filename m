Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWFQLaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWFQLaq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 07:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWFQLaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 07:30:46 -0400
Received: from mail33.syd.optusnet.com.au ([211.29.132.104]:63203 "EHLO
	mail33.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751602AbWFQLap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 07:30:45 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: sound skips on 2.6.16.17
Date: Sat, 17 Jun 2006 21:29:56 +1000
User-Agent: KMail/1.9.3
Cc: Hugo Vanwoerkom <rociobarroso@att.net.mx>, ocilent1@gmail.com,
       linux list <linux-kernel@vger.kernel.org>, Chris Wedgwood <cw@f00f.org>
References: <4487F942.3030601@att.net.mx> <200606161115.53716.ocilent1@gmail.com> <4493D24D.2010902@att.net.mx>
In-Reply-To: <4493D24D.2010902@att.net.mx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606172129.56986.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 June 2006 19:58, Hugo Vanwoerkom wrote:
> ocilent1 wrote:
> > You don't happen to use a VIA chipset do you? For PCLinuxOS kernels, I
> > found that a few people with VIA based mobos started experiencing
> > sound problems (skipping / stuttering) once we hit 2.6.16.17. Backing out
> > the following 2 patches added in 2.6.16.17 seem to fix the problems.
> >
> > 1)  PCI-VIA-quirk-fixup-additional-PCI-IDs.patch
> > 2)  PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch
> >
> > I have attached some patches you might want to try that reverse out the
> > above patches. You will need to apply the patches in the correct order
> > (as above)

> Works like a charm. End of the sound skips.

Not sure if this has been reported to lkml so I'm cc'ing it here and the 
stable maintainer.

-- 
-ck
