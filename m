Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbUJ0P6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUJ0P6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbUJ0P6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:58:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49290 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262495AbUJ0P5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:57:40 -0400
Date: Wed, 27 Oct 2004 16:42:55 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Mathieu Segaud <matt@minas-morgul.org>,
       jfannin1@columbus.rr.com, agk@redhat.com, christophe@saout.de,
       linux-kernel@vger.kernel.org, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
Message-ID: <20041027154255.GB9937@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
	Mathieu Segaud <matt@minas-morgul.org>, jfannin1@columbus.rr.com,
	christophe@saout.de, linux-kernel@vger.kernel.org,
	bzolnier@gmail.com
References: <87oeitdogw.fsf@barad-dur.crans.org> <1098731002.14877.3.camel@leto.cs.pocnet.net> <20041026123651.GA2987@zion.rivenstone.net> <20041026135955.GA9937@agk.surrey.redhat.com> <20041026213703.GA6174@rivenstone.net> <20041026151559.041088f1.akpm@osdl.org> <87hdogvku7.fsf@barad-dur.crans.org> <20041026222650.596eddd8.akpm@osdl.org> <20041027054741.GB15910@suse.de> <20041027064146.GG15910@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027064146.GG15910@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 08:41:46AM +0200, Jens Axboe wrote:
> --- /opt/kernel/linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-10-27 08:29:51.866931262 +0200
> +++ linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-10-27 08:41:20.292172299 +0200
> @@ -987,8 +987,8 @@
>  	isize = i_size_read(inode);

Can that return 0?

Alasdair
-- 
agk@redhat.com
