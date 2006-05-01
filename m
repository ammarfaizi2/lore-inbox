Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWEAVk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWEAVk6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWEAVk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:40:58 -0400
Received: from nproxy.gmail.com ([64.233.182.185]:46254 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932274AbWEAVk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:40:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=QvtKVYejlB+Af+407+OA/JR3ICTQ5cWil25bBCEQZbzCZgra5IRQHiPs+SjLH0e0Fwg45Bj7ACAsZwRc/BEueJrLDju1A6TKBfKCEqJ74p+ZXJgm6y35sxeClyqo/MgtMSgo36zxZBffdJ6bKNbwxw1zrqSE5tnRpAfeXn0HY20=
Date: Tue, 2 May 2006 01:38:59 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jiri Slaby <jirislaby@gmail.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
Message-ID: <20060501213859.GC7170@mipter.zuzino.mipt.ru>
References: <20060430174426.a21b4614.rdunlap@xenotime.net> <Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr> <1146502730.2885.128.camel@hades.cambridge.redhat.com> <Pine.LNX.4.61.0605012219560.32033@yvahk01.tjqt.qr> <4456732B.2090009@gmail.com> <Pine.LNX.4.61.0605012300080.782@yvahk01.tjqt.qr> <1146517650.1921.55.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146517650.1921.55.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 10:07:29PM +0100, David Woodhouse wrote:
> On Mon, 2006-05-01 at 23:01 +0200, Jan Engelhardt wrote:
> >   find rc3 -type f -print0 | xargs -0 perl -i -pe
> >     's/\btask_t\b/struct task_struct'
> >
> > + a compile test afterwards. Something I missed? (Besides that lines
> > may get longer and violate the 80-column CodingStyle rule.)
>
> If we're going to do that, we might as well make it 'struct task'. The
> additional '_struct' is redundant.

struct sighand_struct
	signal_struct
	files_struct
	fs_struct
	sel_arg_struct
	mmap_arg_struct
	vm_area_struct
	tty_struct
	fasync_struct
	rose_facilities_struct
	poll_table_struct
		...

What is the best day for Grand Renaming?

