Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261654AbTC1AQa>; Thu, 27 Mar 2003 19:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261691AbTC1AQa>; Thu, 27 Mar 2003 19:16:30 -0500
Received: from [81.2.110.254] ([81.2.110.254]:7673 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261654AbTC1APm>;
	Thu, 27 Mar 2003 19:15:42 -0500
Subject: Re: [ANNOUNCE] 2.5.66 bio traversal + IDE PIO patches on the way
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0303280106070.11685-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0303280106070.11685-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048811262.3953.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Mar 2003 00:27:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-28 at 00:10, Bartlomiej Zolnierkiewicz wrote:
> > The IDE taskfile stuff for I/O is known broken. Thats why it
> > is currently disabled. I plan to keep it that way until 2.7
> 
> What is broken?
> It works just as good as standard code
> (with taskfile fixes from ide-pio-1 and ide-pio-2 patches)
> ...or I am missing something?

I hadn't realised you had rewritten all the PIO side of it when
I wrote that. Looks like the revised plan is "pure taskfile for
2.6 care of Bartlomiej"

