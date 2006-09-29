Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161484AbWI2TKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161484AbWI2TKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161490AbWI2TKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:10:41 -0400
Received: from xenotime.net ([66.160.160.81]:30650 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161484AbWI2TKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:10:40 -0400
Date: Fri, 29 Sep 2006 12:11:57 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: roger@computer-surgery.co.uk
Subject: Re: fs/bio.c - Hardcoded sector size ?
Message-Id: <20060929121157.0258883f.rdunlap@xenotime.net>
In-Reply-To: <20060928185820.GB4759@julia.computer-surgery.co.uk>
References: <20060928182238.GA4759@julia.computer-surgery.co.uk>
	<20060929113814.db87b8d5.rdunlap@xenotime.net>
	<20060928185820.GB4759@julia.computer-surgery.co.uk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 19:58:21 +0100 linux-kernel-owner@vger.kernel.org wrote:

> On Fri, Sep 29, 2006 at 11:38:14AM -0700, Randy Dunlap wrote:
> > > from bio->bi_bdev->bd_block_size surely - or is some clever code
> > > where all block devices have to translate back to 512 byte sectors
> 
> > Does this answer it for you?
> 
> Ahh, Yup. 
> 
> Is this documented anywhere ? , I'd suggest a <para> in kernel-api.tmpl
> but I'm not sure this is the right place.

I don't know if or where it is documented.
You can submit a patch for it.
If you don't, I'll put it in my todo queue.

---
~Randy
