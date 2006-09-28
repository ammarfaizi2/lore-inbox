Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161474AbWI2TE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161474AbWI2TE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161478AbWI2TE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:04:29 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:165 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1161474AbWI2TE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:04:28 -0400
Date: Thu, 28 Sep 2006 19:58:21 +0100
From: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: fs/bio.c - Hardcoded sector size ?
Message-ID: <20060928185820.GB4759@julia.computer-surgery.co.uk>
References: <20060928182238.GA4759@julia.computer-surgery.co.uk> <20060929113814.db87b8d5.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929113814.db87b8d5.rdunlap@xenotime.net>
X-GPG-Fingerprint: ADAD DF3A AE05 CA28 3BDB  D352 7E81 8852 817A FB7B
X-GPG-Key: 1024D/817AFB7B (wwwkeys.uk.pgp.net)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 11:38:14AM -0700, Randy Dunlap wrote:
> > from bio->bi_bdev->bd_block_size surely - or is some clever code
> > where all block devices have to translate back to 512 byte sectors

> Does this answer it for you?

Ahh, Yup. 

Is this documented anywhere ? , I'd suggest a <para> in kernel-api.tmpl
but I'm not sure this is the right place.

TTFN
-- 
Roger.                          Home| http://www.sandman.uklinux.net/
Master of Peng Shui.      (Ancient oriental art of Penguin Arranging)
Work|Independent Sys Consultant | http://www.computer-surgery.co.uk/
So what are the eigenvalues and eigenvectors of 'The Matrix'? --anon
