Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWGXS2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWGXS2A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 14:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWGXS2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 14:28:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:12984 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751412AbWGXS2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 14:28:00 -0400
From: Andreas Gruenbacher <a.gruenbacher@computer.org>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: include/linux/xattr.h: how much userpace visible?
Date: Mon, 24 Jul 2006 20:31:11 +0200
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>
References: <20060723184343.GA25367@stusta.de> <20060724085701.B2083275@wobbly.melbourne.sgi.com>
In-Reply-To: <20060724085701.B2083275@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607242031.11815.a.gruenbacher@computer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 24 July 2006 00:57, Nathan Scott wrote:
> On Sun, Jul 23, 2006 at 08:43:43PM +0200, Adrian Bunk wrote:
> > Hi,
> >
> > how much of include/linux/xattr.h has to be part of the userspace kernel
> > headers?
>
> None, I think.

None, indeed. The attr package comes with it own version of xattr.h that also 
includes definitions of XATTR_CREATE and XATTR_REPLACE.

Andreas
