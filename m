Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWGaPrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWGaPrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWGaPrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:47:08 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:50408 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1030203AbWGaPrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:47:07 -0400
Date: Mon, 31 Jul 2006 17:46:59 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH 0/6] AVR32 update for 2.6.18-rc2-mm1
Message-ID: <20060731174659.72da734f@cad-250-152.norway.atmel.com>
In-Reply-To: <1154354115351-git-send-email-hskinnemoen@atmel.com>
References: <1154354115351-git-send-email-hskinnemoen@atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 15:55:15 +0200
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> Anyway, 2.6.18-rc2-mm1 boots successfully on my target with these
> patches, but there's something strange going on with NFS and a few
> other things that I didn't notice on 2.6.18-rc1. I'll investigate
> some more and see if I can figure out what's going on.

All forms of write access to the NFS root file system seem to return
-EACCESS. If I leave out git-nfs.patch, the problem goes away, so I'll
try bisecting the NFS git tree tomorrow.

Is there anyway to access it via http?

Haavard
