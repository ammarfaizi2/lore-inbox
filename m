Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWGaSlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWGaSlT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWGaSlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:41:18 -0400
Received: from pat.uio.no ([129.240.10.4]:14056 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030308AbWGaSlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:41:18 -0400
Subject: Re: [PATCH 0/6] AVR32 update for 2.6.18-rc2-mm1
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060731174659.72da734f@cad-250-152.norway.atmel.com>
References: <1154354115351-git-send-email-hskinnemoen@atmel.com>
	 <20060731174659.72da734f@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 11:40:58 -0700
Message-Id: <1154371259.13744.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.214, required 12,
	autolearn=disabled, AWL 1.79, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-31 at 17:46 +0200, Haavard Skinnemoen wrote:
> On Mon, 31 Jul 2006 15:55:15 +0200
> Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> 
> > Anyway, 2.6.18-rc2-mm1 boots successfully on my target with these
> > patches, but there's something strange going on with NFS and a few
> > other things that I didn't notice on 2.6.18-rc1. I'll investigate
> > some more and see if I can figure out what's going on.
> 
> All forms of write access to the NFS root file system seem to return
> -EACCESS. If I leave out git-nfs.patch, the problem goes away, so I'll
> try bisecting the NFS git tree tomorrow.

can you check in /proc/self/mountstats what mount options are set on the
root file system?

> Is there anyway to access it via http?

The individual patches are archived in

  http://client.linux-nfs.org/Linux-2.6.x/2.6.18-rc3/

There is also gitweb access via

  http://linux-nfs.org/cgi-bin/gitweb.cgi

Cheers,
  Trond

