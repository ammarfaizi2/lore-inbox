Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVBVUaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVBVUaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 15:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVBVUaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 15:30:20 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:3540 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261229AbVBVUaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 15:30:13 -0500
Message-ID: <421B976A.8010904@tmr.com>
Date: Tue, 22 Feb 2005 15:34:50 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give  
 dev=/dev/hdXas device
References: <cv5hv3$ana$1@gatekeeper.tmr.com><cv36kk$54m$1@gatekeeper.tmr.com> <Pine.LNX.4.60.0502181249110.5315@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.60.0502181249110.5315@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> I regularly burn tarballs to a CD without useing a filesystem and as 
> long as I use the -pad option when burning I've had no problems reading 
> them (the -pad was nessasary even when I was useing ide-scsi)

That matches my experience, at least as far as the "no problem" part, I 
never tried without -pad because it just seemed as if cdrecord would 
have a better idea of what the drive wanted than I do.

I have burned tarballs, as well as cpio (I like the checking with -Hcrc 
and not overwriting newer versions of a file), and more recently I have 
been burning encrypted filesystem images onto DVDs directly, and that 
works as well.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
