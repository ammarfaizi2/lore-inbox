Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291462AbSBHIJf>; Fri, 8 Feb 2002 03:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291463AbSBHIJ0>; Fri, 8 Feb 2002 03:09:26 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:44764 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S291464AbSBHIJU>; Fri, 8 Feb 2002 03:09:20 -0500
Message-Id: <200202072111.g17LBig0001686@tigger.cs.uni-dortmund.de>
To: Ville Herva <vherva@twilight.cs.hut.fi>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ? 
In-Reply-To: Message from Ville Herva <vherva@niksula.hut.fi> 
   of "Thu, 07 Feb 2002 09:56:07 +0200." <20020207075607.GE534915@niksula.cs.hut.fi> 
Date: Thu, 07 Feb 2002 22:11:44 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva <vherva@niksula.hut.fi> said:

[...]

> With a directory, you lose the information of in which order the patches
> have been applied - unless of course you resort to file dates or some
> such.

Pfui! Think patches 1, 2, 3 in this order; with 2a later superseeding 2...

> I agree that one file is very problematic wrt. patch(1), but I was hoping
> there would be a way to persuade patch into doing the right thing.

They do it in RPM's spec files, listing the patches (and saying if, and
perhaps when, in what order) they have to be applied. A source RPM is not
that much more than a cpio(1)-ball of the sources, patches, and .spec, very
handy a  _single_ file.
-- 
Horst von Brand			     http://counter.li.org # 22616
