Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWITTNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWITTNv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWITTNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:13:51 -0400
Received: from nsm.pl ([195.34.211.229]:530 "EHLO nsm.pl") by vger.kernel.org
	with ESMTP id S932294AbWITTNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:13:50 -0400
Date: Wed, 20 Sep 2006 21:13:44 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: CIJOML <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very slow write on flash drive in sync mode???
Message-ID: <20060920191343.GA15386@irc.pl>
Mail-Followup-To: CIJOML <cijoml@volny.cz>,
	linux-kernel@vger.kernel.org
References: <200609202058.05816.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609202058.05816.cijoml@volny.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 08:58:05PM +0200, CIJOML wrote:
> Hi,
> 
> I use SanDisk cruzer Titanium 2 GB mounted as sync in fstab
> /dev/sda1       /mnt/cruzer_sync      vfat    user,noauto,sync                
> 
> When I use flash drive in sync mode, it writes on it only 64kB/s. When I 
> umount it and mount it in not sync mode but do sync manually after it writes 
> into memory, kernel writes on flash drive 11 MB/s!!! What is wrong in my 
> configuration?

  That's expected with sync vfat mount. Use other filesystem or async.

-- 
Tomasz Torcz                "Funeral in the morning, IDE hacking
zdzichu@irc.-nie.spam-.pl    in the afternoon and evening." - Alan Cox

