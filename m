Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267272AbUHDGjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267272AbUHDGjl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 02:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUHDGjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 02:39:41 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:41876 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S267272AbUHDGjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 02:39:40 -0400
Message-ID: <41108433.9040002@tlinx.org>
Date: Tue, 03 Aug 2004 23:37:39 -0700
From: L A Walsh <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com, nathans@sgi.com
Subject: Re: XFS: how to NOT null files on fsck?
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx>	<40EEC9DC.8080501@tlinx.org> <20040729013049.GE800@frodo>	<410FDA19.9020805@tlinx.org> <m3d627bueu.fsf@averell.firstfloor.org>
In-Reply-To: <m3d627bueu.fsf@averell.firstfloor.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not laptop, 2-CPU workstation used as home "server". :-)



Andi Kleen wrote:

>L A Walsh <lkml@tlinx.org> writes:
>
>  
>
>>Now I know it takes a while before data may end up on disk and that it
>>may not go out to disk in an ordered fashion, but 2-3 days?  This isn't
>>a case of a multi-extent file.  My current fstab is only 1335 bytes long.
>>I doubt it has ever been more than 2.
>>    
>>
>
>Is this perhaps on a laptop? Some scripts for laptop use configure
>insanely long data flush times to conserve HD spin time. Sometimes
>it is even completely turned off (laptop mode). The extent 
>flush is dependent on the configured bdflush or pdflushd data
>timeouts.
>
>The truncate is independent from this because it is flushed with a 
>different path.
>
>-Andi
>
>
>  
>
