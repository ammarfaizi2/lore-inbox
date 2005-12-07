Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751808AbVLGWit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbVLGWit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbVLGWit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:38:49 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:26534 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751811AbVLGWis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:38:48 -0500
Subject: Re: 2.6.15-rc4 Oops in show_smaps()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Keith Mannthey <kmannth@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <a762e240512071437v4424b6f2i2f67f39e0fd29c83@mail.gmail.com>
References: <1133993880.21841.49.camel@localhost.localdomain>
	 <a762e240512071437v4424b6f2i2f67f39e0fd29c83@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 14:39:04 -0800
Message-Id: <1133995144.21841.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 14:37 -0800, Keith Mannthey wrote:
> On 12/7/05, Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > Hi,
> >
> > I am getting Oops while doing
> >
> > cat /proc/<pid>/smaps
> >
> > Known issue ?
> 
> x86_64  2.6.15-rc5 dosen't seem to have this issue.

Are you using CONFIG_SPARSEMEM ?
I found that its something to do with that (not sure).

Thanks,
Badari

