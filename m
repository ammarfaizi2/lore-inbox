Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUARSCk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 13:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbUARSCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 13:02:39 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:35228 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262228AbUARSCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 13:02:38 -0500
Date: Sun, 18 Jan 2004 10:02:32 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
Message-ID: <20040118180232.GD1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Jan Dittmer <j.dittmer@portrix.net>,
	linux-kernel@vger.kernel.org
References: <400A5FAA.5030504@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400A5FAA.5030504@portrix.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 18, 2004 at 11:27:54AM +0100, Jan Dittmer wrote:
> EXT3-fs error (device dm-1): ext3_readdir: bad entry in directory 
> #9783034: rec_len % 4 != 0 - offset=0, inode=1846971784, rec_len=33046, 
> name_len=154
> Aborting journal on device dm-1.
> ext3_abort called.
> EXT3-fs abort (device dm-1): ext3_journal_start: Detected aborted journal
> Remounting filesystem read-only

Run fsck on the filesystem.
