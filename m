Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTIIIsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 04:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTIIIsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 04:48:14 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:8844 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263717AbTIIIsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 04:48:12 -0400
X-Sender-Authentication: net64
Date: Tue, 9 Sep 2003 10:48:10 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-Id: <20030909104810.31170117.skraw@ithnet.com>
In-Reply-To: <20030909070506.GL150921@niksula.cs.hut.fi>
References: <Pine.LNX.4.55L.0308291325480.29088@freak.distro.conectiva>
	<20030829195737.GI150921@niksula.cs.hut.fi>
	<20030909070506.GL150921@niksula.cs.hut.fi>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003 10:05:07 +0300
Ville Herva <vherva@niksula.hut.fi> wrote:

> On Fri, Aug 29, 2003 at 10:57:37PM +0300, you [Ville Herva] wrote:
> > [...]
> > So I copied the rootfs and everything else from the scsi disk to the ide
> > disk (just barely had enough space), and took all the scsi disk partitions
> > away from fstab. After reboot, I have been unable to lock it up with fsx
> > (scsi disk is not accessed at all), but it will take several weeks before
> > I'm confident that the lock up is cured.
> 
> And indeed it did lock even though the scsi disk is not used at all. It just
> took weeks. 
> 
> At the time no heavy IO was going on afaict (but there might have been some
> io.)
> 
> I'm completely out of ideas here. What the heck is the culprit...? Perhaps a
> faulty motherboard?

Hm, after my experiences I would advise you to save time and headache and try
to replace everything but the ide disk at once. This is an easy and fast action
and gives you a chance to tilt any form of hardware error.

Regards,
Stephan
