Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131742AbRDTVJJ>; Fri, 20 Apr 2001 17:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131887AbRDTVI7>; Fri, 20 Apr 2001 17:08:59 -0400
Received: from chromium11.wia.com ([207.66.214.139]:54285 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S131742AbRDTVIs>; Fri, 20 Apr 2001 17:08:48 -0400
Message-ID: <3AE0A646.74079E95@chromium.com>
Date: Fri, 20 Apr 2001 14:12:38 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: mingo@elte.hu, Zach Brown <zab@zabbo.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: numbers?
In-Reply-To: <E14qhu5-0002B8-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

SPEC connections are cumulative of static (70%) and dynamic (30%) pages, with the
dynamic using quite a bit of CPU (25%-30%) and the static pages dataset of several
(6-8) gigabytes.

The chromium server is actually much faster than thttpd and it is a complete web
server.

 - Fabio

Alan Cox wrote:

> > Incidentally the same server running on a kernel with a multiqueue scheduler
> > achieves 1600 connections per second on the same machine, that was the original
> > reason for my message for a better scheduler.
>
> I get 2000 connections a second with a single threaded server called thttpd
> on my setup. Thats out of the box on 2.4.2ac with zero copy/sendfile.
>
> I've never had occasion to frob with tux or specweb

