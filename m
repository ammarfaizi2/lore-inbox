Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSKTRoP>; Wed, 20 Nov 2002 12:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbSKTRoP>; Wed, 20 Nov 2002 12:44:15 -0500
Received: from verein.lst.de ([212.34.181.86]:52746 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261561AbSKTRoO>;
	Wed, 20 Nov 2002 12:44:14 -0500
Date: Wed, 20 Nov 2002 18:50:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unused includes and misleading comments from scsi_lib.c
Message-ID: <20021120185048.A4886@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Patrick Mansfield <patmans@us.ibm.com>,
	James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20021117235449.B9824@lst.de> <20021120084709.A18453@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021120084709.A18453@eng2.beaverton.ibm.com>; from patmans@us.ibm.com on Wed, Nov 20, 2002 at 08:47:09AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 08:47:09AM -0800, Patrick Mansfield wrote:
> I had to add back the smp_lock.h include to compile with CONFIG_PREEMPT,
> as kernel_locked was not defined and is used by in_atomic().

Bah.  Any chance you could fix the header declaring in_atomic() to pull
in smp_lock.h by itself instead?

