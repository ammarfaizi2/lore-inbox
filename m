Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUADTUv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 14:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbUADTUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 14:20:51 -0500
Received: from havoc.gtf.org ([63.247.75.124]:8149 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262126AbUADTUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 14:20:49 -0500
Date: Sun, 4 Jan 2004 14:20:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Mickael Marchand <marchand@kde.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "B. Gajdos" <brian@chem.sk>
Subject: Re: [PATCH] Update : Silicon Image 3114, 4 ports support
Message-ID: <20040104192048.GA17638@gtf.org>
References: <200401041413.20573.marchand@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401041413.20573.marchand@kde.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 02:12:56PM +0100, Mickael Marchand wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> Thanks to the info Brian provided, I was able to set up the 4 ports of the 
> sil3114.
> Attached is the patch for sata_sil.c, tested on a 2.6.1-rc1-mm1 and tested by 
> Brian too.
> 
> I used 
> if (ent->driver_data == sil_3114)   { ... }
> 
> to ensure the 4 ports are probed only for sil3114 , I am not sure this is the 
> correct way to do it (so that sil3112 support is not broken). I guess Jeff 
> will review that :)

Yeah, your patch looks good.  I assume you tested ports 3 and 4?

	Jeff



