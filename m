Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262421AbTCIFCU>; Sun, 9 Mar 2003 00:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262423AbTCIFCO>; Sun, 9 Mar 2003 00:02:14 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:33742 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262421AbTCIFCM>;
	Sun, 9 Mar 2003 00:02:12 -0500
To: Christoph Hellwig <hch@infradead.org>
cc: Joel Becker <Joel.Becker@oracle.com>, Greg KH <greg@kroah.com>,
       Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, akpm@digeo.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] register_blkdev 
In-reply-to: Your message of Sat, 08 Mar 2003 21:52:39 GMT.
             <20030308215239.A782@infradead.org> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12510.1047186486.1@us.ibm.com>
Date: Sat, 08 Mar 2003 21:08:06 -0800
Message-Id: <E18rt2c-0003Fq-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Mar 2003 21:52:39 GMT, Christoph Hellwig wrote:
> What hack to steal every remaining major?  Remember that Linus already said
> that there won't be new static majors anyway.
> 
> > I've done the math with the current available majors.  I don't
> > see 4000 disks there, and that is just life as it exists today,
> 
> were do you get this 4000 disks number from?  Every big system in practice
> is attached to some EMC/LSI/IBM/whatever array anyway that virtualizes
> away the actual disk.

Actually, we have an internal IBM project about to ship that has
requested 5000 physical disks, each multipathed at least once to
each possible node.  They even supposedly have customers ready today.

Yes, they do a lot of virtualization, internal striping, etc. but
they still have done their own math and would like to support 5000
disks on all OS's, including Linux.  Not a problem for most of the
others from what I've heard.

gerrit
