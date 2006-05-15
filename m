Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWEOJtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWEOJtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 05:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWEOJty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 05:49:54 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:27336 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932357AbWEOJty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 05:49:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Date: Mon, 15 May 2006 19:48:44 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au
References: <200605021200.37424.rjw@sisk.pl> <20060512103013.GG28232@elf.ucw.cz> <200605140033.14967.rjw@sisk.pl>
In-Reply-To: <200605140033.14967.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605151948.45345.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 May 2006 08:33, Rafael J. Wysocki wrote:
> On Friday 12 May 2006 12:30, Pavel Machek wrote:
> > > Please also remember that you are introducing complexity in other ways,
> > > with that swap prefetching code and so on. Any comparison in speed
> > > should include the time to fault back in pages that have been
> > > discarded.
> >
> > Well, swap prefetching is useful for other workloads, too; so it gets
> > developed/tested outside swsusp.
>
> Still my experience indicates that it doesn't play very nice with swsusp
> and unfortunately it hogs the I/O.

There is no swap prefetching code linked in any way to swsusp suspend or 
resume on mainline or -mm. It was a preliminary experiment and Rafael lost 
interest in it so I never bothered pursuing it.

-- 
-ck
