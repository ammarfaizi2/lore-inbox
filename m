Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313315AbSDUAKk>; Sat, 20 Apr 2002 20:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313316AbSDUAKj>; Sat, 20 Apr 2002 20:10:39 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:7838 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S313315AbSDUAKi>;
	Sat, 20 Apr 2002 20:10:38 -0400
Date: Sun, 21 Apr 2002 10:09:45 +1000
From: Anton Blanchard <anton@samba.org>
To: "J. Dow" <jdow@earthlink.net>
Cc: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre7aa1
Message-ID: <20020421000945.GC26727@krispykreme>
In-Reply-To: <Pine.LNX.4.33.0204202310360.21635-100000@sharra.ivimey.org> <0d6901c1e8be$acfe6cf0$1125a8c0@wednesday>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> "Flush" is a well known term of art. And as you note, Ruth, "sync" is
> short for synchronize. Is cleaning up the use of language in the computer
> arts the purpose we are all here?

Andrew makes a good point, even if the humour around it is lost on
Americans. Most people do not understand flush_dcache_page,
flush_icache_page, flush_icache_range, flush_page_to_ram.

Perhaps invalidate_icache_* and writeback_dcache_* would make more sense
but the current functions are so ingrained it would be a hard thing to do.

Anton
