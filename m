Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbTGHSFA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 14:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbTGHSE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 14:04:59 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:9408 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265163AbTGHSE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 14:04:58 -0400
Date: Tue, 08 Jul 2003 11:19:40 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Hanna Linder <hannal@us.ibm.com>, Matthew Wilcox <willy@debian.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] Fastwalk: reduce cacheline bouncing of d_count (Changelog@1.1024.1.11)
Message-ID: <38440000.1057688380@w-hlinder>
In-Reply-To: <shsvfucanzx.fsf@charged.uio.no>
References: <16138.53118.777914.828030@charged.uio.no><1057673804.4357.27.camel@dhcp22.swansea.linux.org.uk><16138.56467.342593.715679@charged.uio.no><1057677613.4358.33.camel@dhcp22.swansea.linux.org.uk><20030708164426.GB10004@www.13thfloor.at>
 <1057683213.5228.3.camel@dhcp22.swansea.linux.org.uk><20030708170628.GA13593@www.13thfloor.at><20030708172028.GB1939@parcelfarce.linux.theplanet.co.uk><27230000.1057686164@w-hlinder> <shsvfucanzx.fsf@charged.uio.no>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, July 08, 2003 08:10:10 PM +0200 Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

>>>>>> " " == Hanna Linder <hannal@us.ibm.com> writes:
> 
>      > The change Trond pointed out was added by Al Viro
>      > after fastwalk was included in 2.5.11 which I backported.
> 
> IIRC, Al vetoed the NFS cto change that went into 2.4.x because he
> claimed he was planning on providing an alternative fix that would
> better fit the unionfs.
> As that apparently won't materialize in 2.6.x, I'm in any case
> planning on presenting the open(".") patch (or some variant of it) to
> Linus.

Then I apologize for my bad memory. I dont remember that thread.
This fastwalk stuff was originally written over a year ago.

Please push your bugfix as you know the NFS area much better
than I do.

Thanks.

Hanna


