Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262727AbREOKYm>; Tue, 15 May 2001 06:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262724AbREOKYW>; Tue, 15 May 2001 06:24:22 -0400
Received: from cherry.napri.sk ([194.1.128.4]:11269 "HELO cherry.napri.sk")
	by vger.kernel.org with SMTP id <S262723AbREOKYQ>;
	Tue, 15 May 2001 06:24:16 -0400
Date: Tue, 15 May 2001 12:24:06 +0200
From: Peter Kundrat <kundrat@kundrat.sk>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: MS_RDONLY patch (do_remount_sb and cramfs/inode.c)
Message-ID: <20010515122406.A4564@napri.sk>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010515112726.A28961@napri.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0i
In-Reply-To: <20010515112726.A28961@napri.sk>; from kundrat@kundrat.sk on Tue, May 15, 2001 at 11:27:26AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 11:27:26AM +0200, Peter Kundrat wrote:
> This patch does:
> - set MS_RDONLY flag in cramfs superblock
> - doesnt allow -w remount in do_remount_sb 
>   if the filesystem has MS_RDONLY set.

Oh, ignore the second part. Seems i'd have to supply remount_fs super
op to prevent that.

pkx
-- 
Peter Kundrat
peter@kundrat.sk
