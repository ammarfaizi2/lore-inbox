Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313321AbSDFALc>; Fri, 5 Apr 2002 19:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313322AbSDFALW>; Fri, 5 Apr 2002 19:11:22 -0500
Received: from horkos.telenet-ops.be ([195.130.132.45]:53185 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S313321AbSDFALM>; Fri, 5 Apr 2002 19:11:12 -0500
Date: Sat, 6 Apr 2002 02:11:09 +0200
From: Kurt Roeckx <Q@ping.be>
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: fsck on ext3 after 20 mounts reports i_blocks=n should be m
Message-ID: <20020406021109.A391@ping.be>
In-Reply-To: <20020405235647.A29670@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 11:56:47PM +0200, bert hubert wrote:
> Hi people,
> 
> My laptop which runs 2.5.6 today decided to fsck / because it had been
> mounted 20 times. During those 20 times I think it had in the order of 5
> unclean shutdowns (empty battery mostly), all of them running 2.5.6
> according to 'last'.
> 
> The fsck reports, from what I can recall:
> 
> inode X i_blocks=n, should be m. FIXED

This happens when your fs was full.  Andrew Morton mailed a patch
to the list a few days ago.


Kurt

