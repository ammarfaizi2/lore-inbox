Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273495AbRJKH2Z>; Thu, 11 Oct 2001 03:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273463AbRJKH2G>; Thu, 11 Oct 2001 03:28:06 -0400
Received: from t2.redhat.com ([199.183.24.243]:43769 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S273385AbRJKH1z>; Thu, 11 Oct 2001 03:27:55 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <16172.1002749316@ocs3.intra.ocs.com.au> 
In-Reply-To: <16172.1002749316@ocs3.intra.ocs.com.au> 
To: Keith Owens <kaos@ocs.com.au>
Cc: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>, tkhoadfdsaf@hotmail.com,
        alan@lxorguk.ukuu.org.uk, viro@math.psu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Tainted Modules Help Notices 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Oct 2001 08:27:17 +0100
Message-ID: <31498.1002785237@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  If somebody uses a different string, their license is not GPL. 

We do not care if they use a licence which is not GPL. We only care if they 
use a licence which is not GPL-compatible.

>  To triage bug reports.  Any bug report against a tainted kernel is
> almost certain to be bounced with "your kernel contains code that we
> do not have the source for, send this bug report to the company that
> maintains the non-GPL code".

In the case which started this thread, the non-GPL code in question was part
of the kernel source tree, and we _do_ have the source for it. It was the
BSD-licensed PPP compression code. 

You seem to have claimed that this is not a bug, but that it's intentional.
Are you therefore going to make changes to the build system so that the
static kernel image will boot up marked as tainted if CONFIG_PPP_BSDCOMP=y?

--
dwmw2


