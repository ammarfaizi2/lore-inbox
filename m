Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132145AbRCYSIn>; Sun, 25 Mar 2001 13:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132143AbRCYSIX>; Sun, 25 Mar 2001 13:08:23 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:53026 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S132142AbRCYSIO>;
	Sun, 25 Mar 2001 13:08:14 -0500
Message-ID: <20010325200735.C6759@win.tue.nl>
Date: Sun, 25 Mar 2001 20:07:35 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Kurt Garloff <garloff@suse.de>, "James A. Sutherland" <jas88@cam.ac.uk>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010322124727.A5115@win.tue.nl> <Pine.LNX.4.30.0103231721480.4103-100000@dax.joh.cam.ac.uk> <20010325013241.F2274@garloff.casa-etp.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010325013241.F2274@garloff.casa-etp.nl>; from Kurt Garloff on Sun, Mar 25, 2001 at 01:32:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2001 at 01:32:42AM +0100, Kurt Garloff wrote:
> On Fri, Mar 23, 2001 at 05:26:22PM +0000, James A. Sutherland wrote:
> > If SuSE's install program needs more than a quarter Gb of RAM, you need a
> > better distro.
> 
> Well, it's rpm ...

Yes. I investigated and found rpm's data base corrupted, and rpm cannot handle
that. Since I have several occurrences of rpm being killed by the oom killer
in my logs it is entirely possible that the data base got corrupted because
rpm was killed while in the process of updating it.


