Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276951AbRJCTLB>; Wed, 3 Oct 2001 15:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276953AbRJCTKu>; Wed, 3 Oct 2001 15:10:50 -0400
Received: from [209.202.108.240] ([209.202.108.240]:15883 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S276951AbRJCTKm>; Wed, 3 Oct 2001 15:10:42 -0400
Date: Wed, 3 Oct 2001 15:10:55 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: bad blocks and rebooting
In-Reply-To: <20011003134423.A28512@home.com>
Message-ID: <Pine.LNX.4.33.0110031509560.25683-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001, Subba Rao wrote:

> I have a system setup as a black box. If the system is powered
> off accidentally, and upon powering on the system keeps rebooting
> after trying to do the file system consistency check. The file
> system message is to run "ef2fsck -v -y <partition>. Is there
> anyway to force this check at lilo prompt?

That's what journaled filesystems like ext3, ReiserFS, XFS, and JFS are for.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

