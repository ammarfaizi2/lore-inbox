Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTDULe7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 07:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263814AbTDULe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 07:34:59 -0400
Received: from mail.ithnet.com ([217.64.64.8]:13843 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263812AbTDULe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 07:34:58 -0400
Date: Mon, 21 Apr 2003 13:46:15 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: john@grabjohn.com, linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030421134615.2d5c7f8e.skraw@ithnet.com>
In-Reply-To: <200304211113.h3LBDuu08057@Port.imtp.ilyichevsk.odessa.ua>
References: <200304210935.h3L9ZLXc000256@81-2-122-30.bradfords.org.uk>
	<200304211113.h3LBDuu08057@Port.imtp.ilyichevsk.odessa.ua>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003 14:22:01 +0300
Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:

> On 21 April 2003 12:35, John Bradford wrote:
> > > > Modern disks generally do this kind of thing themselves.  By the
> > > > time
> > >
> > >                ^^^^^^^^^^^^
> > > How many times does Stephan need to say it? 'Generally do'
> > > is not enough, because it means 'sometimes they dont'.
> >
> > OK, _ALL_ modern disks do.
> >
> > Name an IDE or SCSI disk on sale today that doesn't retry on write
> > failiure.  Forget I said 'Generally do'.
> 
> I don't know about drives currently on sale, but I think
> it is possible that some Flash or DRAM-based IDE pseudo-disks
> do not have extensive sector remapping features. They can just
> do ECC thing and error out.

Good example. Very good example, because it shows a possibility that some part
of a "drive" may be technically damaged and have _no_ influence at all on the
rest of the "media".

> [...]
> I prefer a big fat ugly kernel printk (KERN_ERR) across my console
> and all the logs: "ext3fs: write error at sector #NNNN. Marking as bad.
> Your disk may be failing!"

I would favor that, too.

> What's wrong with me?

Maybe you don't own a good color copy station for printing your own money bills
... ;-)

Regards,
Stephan
