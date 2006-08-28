Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWH1TlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWH1TlY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWH1TlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:41:24 -0400
Received: from mga07.intel.com ([143.182.124.22]:46489 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751380AbWH1TlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:41:22 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,176,1154934000"; 
   d="scan'208"; a="108704765:sNHT19429312"
Date: Mon, 28 Aug 2006 12:41:02 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Val Henson <val.henson@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Ron Yorston <rmy@tigress.co.uk>,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Mingming Cao <cmm@us.ibm.com>
Subject: Re: [PATCH] ext2: avoid needless discard of preallocated blocks
Message-ID: <20060828194100.GF25003@goober>
References: <200608171945.k7HJjaLk029781@tiffany.internal.tigress.co.uk> <20060819224603.bf687be2.akpm@osdl.org> <200608201148.k7KBm8XA005948@tiffany.internal.tigress.co.uk> <1156087499.23756.39.camel@laptopd505.fenrus.org> <70b6f0bf0608200833r46305438x783e62b4827db0ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70b6f0bf0608200833r46305438x783e62b4827db0ef@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 08:33:29AM -0700, Val Henson wrote:
> On 8/20/06, Arjan van de Ven <arjan@infradead.org> wrote:
> >maybe porting the reservation code to ext2 (as Val has done) is a nicer
> >long term solution..
> 
> The even nicer solution long term solution is to abstract out the
> reservation code as much as possible and share it.   But if you want
> my (hasty and unlovely) port, you can grab it out of this patch:
> 
> http://infohost.nmt.edu/~val/patches/fswide_latest_patch

As it turns out, I already split it out:

http://infohost.nmt.edu/~val/patches/resv_only_patch

I added this to the Easy File System Projects wiki:

http://linuxfs.pbwiki.com/EasyFsProjects

-VAL
