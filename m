Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTFBPMi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTFBPMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:12:38 -0400
Received: from garnet.acns.fsu.edu ([146.201.2.25]:12003 "EHLO
	garnet.acns.fsu.edu") by vger.kernel.org with ESMTP id S262427AbTFBPMg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:12:36 -0400
Message-ID: <3EDB6C4A.3040008@cox.net>
Date: Mon, 02 Jun 2003 11:24:58 -0400
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jaroslav Kysela <perex@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/BK] ALSA update 0.9.4
References: <Pine.LNX.4.44.0306012117170.7783-100000@pnote.perex-int.cz>
In-Reply-To: <Pine.LNX.4.44.0306012117170.7783-100000@pnote.perex-int.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela wrote:
> Linus, please do a
> 
>   bk pull http://linux-sound.bkbits.net/linux-sound
> 
> The GNU patch is available at:
> 
>   ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-06-01.patch.gz
> 
> The pull command will update the following files:
> 
(SNIP)
>  sound/usb/usbaudio.c                                         |  420 ++
>  sound/usb/usbaudio.h                                         |    3 
(SNIP)
>  158 files changed, 16599 insertions(+), 3235 deletions(-)

Just compiled -bk4, and the above 2 files make this patch a broken one.
'usbaudio.c' does not compile. Function parameters were changed, but the 
usage in the functions were not changed/removed.
Need a patch.

-David

