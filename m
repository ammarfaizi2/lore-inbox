Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVGYUi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVGYUi1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVGYUi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:38:27 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:44339 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261282AbVGYUi0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:38:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LdSfZczXAZA7i3egIGwHxV6dEgEtP8OQ5WPLvByV1ML1yo1lnw6QTweZn4KzkJxGf8op1z0zlHsUFhVYj7NLB4L+3rmnhvSubdhX01p6ImholwP+AGzRny3mbmIuoViMWtH0LbaUPDQqPOhPKBA7kn0U6r2i1/OfG8BncrGsiPo=
Message-ID: <9a874849050725133853953bd4@mail.gmail.com>
Date: Mon, 25 Jul 2005 22:38:25 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood-
Cc: Andreas Baer <lnx1@gmx.net>, Willy Tarreau <willy@w.ods.org>,
       linux-kernel@vger.kernel.org, pmarques@grupopie.com
In-Reply-To: <20050725200330.GA20811@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local>
	 <42E4E4B0.6050904@gmx.net> <20050725152425.GA24568@alpha.home.local>
	 <42E542D5.3080905@gmx.net>
	 <20050725200330.GA20811@harddisk-recovery.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/05, Erik Mouw <erik@harddisk-recovery.com> wrote:
> On Mon, Jul 25, 2005 at 09:51:49PM +0200, Andreas Baer wrote:
> >
> > Willy Tarreau wrote:
> > >On Mon, Jul 25, 2005 at 03:10:08PM +0200, Andreas Baer wrote:
> > >>Here I have
> > >>
> > >>        /dev/hda:  26.91 MB/sec
> > >>        /dev/hda1: 26.90 MB/sec    (Windows FAT32)
> > >>        /dev/hda7: 17.89 MB/sec    (Linux EXT3)
> > >>
> > >>Could you give me a reason how this is possible?
> > >
> > >
> > >a reason for what ? the fact that the notebook performs faster than the
> > >desktop while slower on I/O ?
> >
> > No, a reason why the partition with Linux (ReiserFS or Ext3) is always
> > slower
> > than the Windows partition?
> 
> Easy: Drives don't have the same speed on all tracks. The platters are
> built-up from zones with different recording densities: zones near the
> center of the platters have a lower recording density and hence a lower
> datarate (less bits/second pass under the head). Zones at the outer
> diameter have a higher recording density and a higher datarate.
> 
It's even more complex than that as far as I know, you also have the
issue of seek times - tracks near the middle of the platter will be
nearer the head more often (on average) then tracks at the edge.

For people who like visuals, IBM has a nice little picture in their
AIX performance tuning guide :
http://publib.boulder.ibm.com/infocenter/pseries/index.jsp?topic=/com.ibm.aix.doc/aixbman/prftungd/diskperf2.htm


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
