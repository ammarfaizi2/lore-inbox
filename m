Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313754AbSDHVUW>; Mon, 8 Apr 2002 17:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313755AbSDHVUV>; Mon, 8 Apr 2002 17:20:21 -0400
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:5960 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S313754AbSDHVUU>; Mon, 8 Apr 2002 17:20:20 -0400
From: brian@worldcontrol.com
Date: Mon, 8 Apr 2002 14:15:59 -0700
To: Pavel Machek <pavel@ucw.cz>
Cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make swsusp actually work
Message-ID: <20020408211558.GA1864@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Pavel Machek <pavel@ucw.cz>, alan@redhat.com,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020407233725.GA15559@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 01:37:26AM +0200, Pavel Machek wrote:
> Hi!
> 
> There were two bugs, and linux/mm.h one took me *very* long to
> find... Well, those bits used for zone should have been marked. Plus I
> hack ide_..._suspend code not to panic, and it now seems to
> work. [Sorry, 2pm, have to get some sleep.]

I've applied both this patch and the earlier one, and now my
2.4.19-pre5-ac3 system can suspend and it can resume.  However,
when it resumed, I was stuck in the kernel SysRq function.

Couldn't get out of it.

And nothing seemed to work, other than it kept displaying the
help each time I touched a key.

On the other hand, the swsusp in 2.4.18-WOLK3.3 works correctly.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2002 By Brian Litzinger, All Rights Reserved
