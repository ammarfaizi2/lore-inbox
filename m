Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVGDNKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVGDNKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 09:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVGDNKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 09:10:33 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:7359 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261686AbVGDNJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 09:09:44 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: FUSE merging? (2)
To: Miklos Szeredi <miklos@szeredi.hu>, frankvm@frankvm.com, miklos@szeredi.hu,
       frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk,
       arjan@infradead.org, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Mon, 04 Jul 2005 15:09:29 +0200
References: <4ly7J-14H-9@gated-at.bofh.it> <4lRDA-4U-55@gated-at.bofh.it> <4lSJa-16Z-7@gated-at.bofh.it> <4m5ZG-2ok-1@gated-at.bofh.it> <4maPM-5XJ-5@gated-at.bofh.it> <4mcHV-7no-21@gated-at.bofh.it> <4mduc-7Zg-1@gated-at.bofh.it> <4mfcJ-UT-17@gated-at.bofh.it> <4mitV-3mL-3@gated-at.bofh.it> <4mv7Q-2Ki-19@gated-at.bofh.it> <4mwdG-3AP-15@gated-at.bofh.it> <4mwwX-3N9-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DpQhW-0004Sv-Iw@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> I see your point.  But then this is really not a security issue, but
> an "are you sure you want to format C:" style protection for the
> user's own sake.  Adding a mount option (checked by the library) for
> this would be fine.  E.g. with "mount_nonempty" it would not refuse to
> mount on a non-leaf dir, and README would document, that using this
> option might cause trouble.  Otherwise the mount would be refused with
> a reference to the above option.

IMO that should be a generic mount option, not FUSE specific.
Maybe the default could vary for each fs, but I'd vote against that.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
