Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWEMOnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWEMOnk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 10:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWEMOnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 10:43:40 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:29079 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S1751141AbWEMOnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 10:43:39 -0400
Date: Sat, 13 May 2006 16:43:34 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages. (might be dm related)
Message-ID: <20060513144334.GA6013@uio.no>
References: <20060420160549.7637.patches@notabene> <1060420062955.7727@suse.de> <20060420003839.1a41c36f.akpm@osdl.org> <20060426204809.GA15462@uio.no> <20060426135809.10a37ec3.akpm@osdl.org> <20060513134908.GA4480@uio.no> <20060513073344.4fcbc46b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060513073344.4fcbc46b.akpm@osdl.org>
X-Operating-System: Linux 2.6.16.11 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11+cvs20060403
X-Spam-Score: -2.6 (--)
X-Spam-Report: Status=No hits=-2.6 required=5.0 tests=AWL,BAYES_00,NO_RELAYS version=3.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 07:33:44AM -0700, Andrew Morton wrote:
> Well if it's the same software lineup on new hardware, one would also
> suspect that hardware.  Is it new?

Yes, it's new. The differences aren't that big, though: The motherboard has
been changed, and there's an extra sil3114 controller.

> Does it run other kernels OK?

2.6.15.4 appears to be fine, but I haven't tested it enough to make sure.
(I'm running 2.6.17-rc4 without swap now, so we'll see.)

> Does it always crash in the same manner?

Yes; consistently and in the same place after about the same amount of time.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
