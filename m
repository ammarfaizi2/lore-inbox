Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWJQMRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWJQMRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 08:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWJQMRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 08:17:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44219 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750739AbWJQMRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 08:17:30 -0400
From: Andi Kleen <ak@suse.de>
To: caglar@pardus.org.tr
Subject: Re: [RFC] Avoid PIT SMP lockups
Date: Tue, 17 Oct 2006 14:16:50 +0200
User-Agent: KMail/1.9.3
Cc: Zachary Amsden <zach@vmware.com>, Gerd Hoffmann <kraxel@suse.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
References: <1160170736.6140.31.camel@localhost.localdomain> <200610170121.51492.caglar@pardus.org.tr> <200610171505.53576.caglar@pardus.org.tr>
In-Reply-To: <200610171505.53576.caglar@pardus.org.tr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200610171416.50881.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 14:05, S.Çağlar Onur wrote:
> 17 Eki 2006 Sal 01:21 tarihinde, S.Çağlar Onur şunları yazmıştı: 
> > 17 Eki 2006 Sal 01:17 tarihinde, Zachary Amsden şunları yazmıştı:
> > > My nasty quick patch might not apply - the only tree I've got is a very
> > > hacked 2.6.18-rc6-mm1+local-patches thing, but the fix should be obvious
> > > enough.
> >
> > Ok, I'll test and report back...
> 
> Both 2.6.18 and 2.6.18.1 boots without any problem (and of course without 
> noreplacement workarund) with that patch.

Ok thanks.

I still think we need a solution for the NMIs though. I will think
about it.

-Andi
