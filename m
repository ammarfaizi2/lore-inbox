Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129056AbRBBMsC>; Fri, 2 Feb 2001 07:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129100AbRBBMrx>; Fri, 2 Feb 2001 07:47:53 -0500
Received: from buserror.convergence.de ([212.84.236.5]:60151 "EHLO wintermute")
	by vger.kernel.org with ESMTP id <S129056AbRBBMrh>;
	Fri, 2 Feb 2001 07:47:37 -0500
Message-ID: <3A7AAC4F.FA9BB97D@convergence.de>
Date: Fri, 02 Feb 2001 13:47:11 +0100
From: Szymon Polom <polom@convergence.de>
Organization: convergence integrated media GmbH
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fredrik Vraalsen <vraalsen@cs.uiuc.edu>, axboe@suse.de,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        livid-dev@linuxvideo.org,
        "Peter Rasmussen (udgaard)" <plr@udgaard.com>
Subject: Re: [livid-dev] [Patch] DVD bugfix in ide-cd.c
In-Reply-To: <200102012210.XAA00328@udgaard.com>
			<sz2u26d4tt8.fsf@kazoo.cs.uiuc.edu> <sz2lmrp4qib.fsf_-_@kazoo.cs.uiuc.edu> <3A7AA8BE.B302C8D8@convergence.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Szymon Polom wrote:

> Fredrik Vraalsen wrote:
> >
> > This is a small patch to Linux kernel 2.4.1 that fixes a problem with
> > DVD playback in OMS (Open Media System).  With the stock 2.4.1 kernel
> > OMS will only play up to a certain point on the DVD before it complains
> > about no more data left on input (basically read() returns 0).  This
> > patch reverts a change between 2.4.0 and 2.4.1.
> 
> What's wrong with the people maintaining the source? The bug has been
> fixed in 2.2.18 and 2.4.0-test8. I can't imagine how the bug has been
> "implemented" in 2.4.1 again.
> 
> Any ideas?

I have to revoke my statement. The cached toc problem i meant was in
cdrom_get_toc_entry() not in cdrom_read_toc().

Bye... SP.
-- 
Szymon Polom                              polom@convergence.de
convergence integrated media GmbH         http://www.convergence.de
Rosenthaler Str. 51                       fon: +49(0)30-72 62 06 68 
D-10178 Berlin                            fax: +49(0)30-72 62 06 55
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
