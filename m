Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269265AbUINLAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269265AbUINLAk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269262AbUINLAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:00:39 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:4243 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S269265AbUINK7v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 06:59:51 -0400
From: Alistair John Strachan <alistair@devzero.co.uk>
Reply-To: alistair@devzero.co.uk
To: Nathan Scott <nathans@sgi.com>
Subject: Re: Copying huge amount of data on ReiserFS, XFS and Silicon Image 3112 cause oops.
Date: Tue, 14 Sep 2004 11:59:54 +0100
User-Agent: KMail/1.7
References: <414622C9.1030701@post.pl> <20040914081440.GC5083@frodo>
In-Reply-To: <20040914081440.GC5083@frodo>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409141159.54889.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 September 2004 09:14, you wrote:
> On Tue, Sep 14, 2004 at 12:44:25AM +0200, Marcin Garski wrote:
> > [Please CC me on replies, I am not subscribed to the list, thanks]
> >
> > Hello,
> >
> > I bought a new HDD Maxtor 6Y160M0 and connected it as hdg to Sil 3112
> > (CONFIG_BLK_DEV_SIIMAGE) on Abit NF7-S V2.0. I also have ST380013AS
> > (with Fedora Core 2 on hde2 and 2.6.5 kernel) as hde.
>
> Possible hardware problems?  Have you run memtest there?
>
> Was 4KSTACKS enabled in those kernels (I think so)? - XFS
> has one known problem with that option when running low on
> space (patch fixing that is being tested atm) and I think
> the reiserfs folks had some 4k stack issues as well at one
> point, so that might be another explanation.
>

Just out of interest, how low is "low space"? I've got a few machines I can't 
reboot running XFS+4K stacks; no problems so far but I'd like to sidestep 
them if possible.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
