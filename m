Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUHCUGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUHCUGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUHCUGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:06:13 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:15046 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S266824AbUHCUGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:06:11 -0400
Date: Tue, 3 Aug 2004 22:06:10 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Heikki Linnakangas <hlinnaka@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Retrying root mounting for booting off USB
Message-ID: <20040803200610.GA5148@janus>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	Heikki Linnakangas <hlinnaka@iki.fi>, linux-kernel@vger.kernel.org
References: <Pine.OSF.4.60.0408032154400.205783@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.60.0408032154400.205783@kosh.hut.fi>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 10:33:04PM +0300, Heikki Linnakangas wrote:
> Currently, booting off USB devices doesn't work in all environments. The 
> root fs mounting code in init/do_mounts.c decides that the root filesystem 
> is not available and gives up before the USB mass storage driver gets 
> fully initialized.

what do you think of http://dedasys.com/freesoftware/patches/blkdev_wakeup.patch ?

http://marc.theaimsgroup.com/?l=linux-kernel&m=109122295308836&w=2

-- 
Frank
