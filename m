Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265703AbUFXVlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265703AbUFXVlo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbUFXVki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:40:38 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:28320 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265703AbUFXVkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:40:07 -0400
X-Envelope-From: kraxel@bytesex.org
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Testing for kernel features in external modules
References: <20040624203043.GA4557@mars.ravnborg.org>
	<20040624203516.GV31203@schnapps.adilger.int>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 24 Jun 2004 23:07:45 +0200
In-Reply-To: <20040624203516.GV31203@schnapps.adilger.int>
Message-ID: <87d63ois0u.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> writes:

> Ideally, when people make an incompatible kernel API change like this
> they would just #define HAVE_REMAP_PAGE_RANGE_VMA in the header that
> declares remap_page_range() directly (e.g. KERNEL_AS_O_DIRECT was added
> for this reason) instead of external builds having to figure this out
> themselves.  Adding the check script is no less work than just adding
> the #define to the appropriate header directly.

I fully agree here, just having #defines for kernel features (which
can't be detected otherwise) is much easier.

  Ge- "#define HAVE_V4L2 1" rd

-- 
2004-06-24: Switched mail/news setup to a new machine.  If something
is unusual/strange/broken/whatever feel free to drop me a note.
	=> kraxel@bytesex.org
