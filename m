Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVEVPWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVEVPWU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 11:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVEVPWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 11:22:20 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:6039 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261816AbVEVPWP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 11:22:15 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binutils-2.16 & kernel-2.6.11.10
Date: Sun, 22 May 2005 16:21:42 +0100
User-Agent: KMail/1.8
References: <200505212259.j4LMxqAS017253@wildsau.enemy.org> <200505221151.46592.andrew@walrond.org>
In-Reply-To: <200505221151.46592.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505221621.42931.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 May 2005 11:51, you wrote:
> On Saturday 21 May 2005 23:59, Herbert Rosmanith wrote:
> > > http://www.kernel.org/pub/linux/devel/binutils/linux-2.6-seg-5.patch
> > > http://www.kernel.org/pub/linux/devel/binutils/linux-2.4-seg-4.patch
> > >
> > > should probably fix that.
> >
> > interesting, that's the same patch (s/movl/movw/), but it is date
> > from *march* 2005.
> >
> > why is this not in the kernel source yet? It is definitely not
> > okay to "movl" a segreg.
>
> I'd also like to know the status of these patches; I've avoided the last
> couple binutils upgrades because of HJL's attached kernel patches and
> implied Linux build problems.

For what it's worth, I recently built an adapted LFS SVN for x86-64, using 
HJL's binutils 2.16.90.0.2. A few weeks later, and still no problems. 
Literally the only package I had difficulty building was Linux itself, and 
the attached patches seem to work fine.

Let's hope they get into mainline shortly.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
