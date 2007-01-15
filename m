Return-Path: <linux-kernel-owner+w=401wt.eu-S1750986AbXAOQ3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbXAOQ3R (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 11:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbXAOQ3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 11:29:16 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:10034 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750981AbXAOQ3P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 11:29:15 -0500
Date: Mon, 15 Jan 2007 16:29:11 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: x86 instability with 2.6.1{8,9}
Message-ID: <20070115162911.GA13198@deepthought>
References: <20070101160158.GA26547@deepthought> <200701021225.57708.lenb@kernel.org> <20070102180425.GA18680@deepthought> <200701021342.32195.lenb@kernel.org> <20070102193459.GA19894@deepthought> <20070106140459.a6b72039.randy.dunlap@oracle.com> <20070107142641.GA30379@deepthought>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20070107142641.GA30379@deepthought>
User-Agent: Mutt/1.5.12-2006-07-14
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 02:26:41PM +0000, Ken Moffat wrote:
> 
>  I guess that when it does have problems, it is mostly within 30
> minutes of booting - otherwise, it can be up all day.  So, for the
> moment I'm hopeful that changing the config will help, but it will
> be several days before I feel at all confident.
>

 Update: it doesn't seem to relate to using/not using APIC.

 Last Thursday it twice failed during booting (from cold), with
messages all over the screen.  Again, nothing reached the logs
despite my best attempts.  The second time, I scrolled back to try
to copy it by hand, but there were several sets of messages and I'm
not sure if I'd managed to get to the first of them, or if that had
dropped out.  It seemed to be something to do with highmem (also
noticed highmem in the screen messages the first time).  I tried to
copy it by hand, but it all scrolled out before I'd copied anything
useful as a load of 'atkbd.c Spurious ACK on isa0060/serio' messages
appeared. 

 Today, I've built 2.6.19.2 without highmem (the box only has 1GB,
dunno why I'd included that in the original config) and I will
continue to wait patiently for either a week without problems, or
something that I can manage to note - although I think at the moment
that the second coming of the great prophet Zarquon is more likely.

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
