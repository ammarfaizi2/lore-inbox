Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267679AbUJGURg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267679AbUJGURg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUJGUQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:16:05 -0400
Received: from mail4.utc.com ([192.249.46.193]:16558 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S268042AbUJGUN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:13:57 -0400
Message-ID: <4165A369.60306@cybsft.com>
Date: Thu, 07 Oct 2004 15:13:29 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3 fails to detect aic7xxx
References: <1097178019.24355.39.camel@localhost>
In-Reply-To: <1097178019.24355.39.camel@localhost>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> I just booted 2.6.9-rc3-mm3 and got the good ol' 
> 
> VFS: Cannot open root device "sda2" or unknown-block(0,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
> 
> backing out bk-scsi.patch seems to fix it.  I believe this worked in
> 2.6.9-rc3-mm2.
> 
> -- Dave

While I can't verify that backing out bk-scsi.patch fixes it for me yet, 
I can verify that I get the exact same error trying to boot this kernel. 
I too am using the aic7xxx.

kr
