Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUIMGjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUIMGjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 02:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUIMGjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 02:39:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15300 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266187AbUIMGjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 02:39:42 -0400
Date: Mon, 13 Sep 2004 08:38:12 +0200
From: Jens Axboe <axboe@suse.de>
To: alan <alan@clueserver.org>
Cc: Supphachoke Suntiwichaya <mrchoke@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: LITE-ON COMBO SOHC-5232K
Message-ID: <20040913063811.GE2326@suse.de>
References: <66bd7830040912211143759341@mail.gmail.com> <Pine.LNX.4.44.0409122022480.18569-100000@www.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409122022480.18569-100000@www.fnordora.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12 2004, alan wrote:
> On Mon, 13 Sep 2004, Supphachoke Suntiwichaya wrote:
> 
> > On Sun, 12 Sep 2004 12:57:25 +0200, Jens Axboe <axboe@suse.de> wrote:
> > > On Fri, Sep 10 2004, Supphachoke Suntiwichaya wrote:
> > > > Hi,
> > > >
> > > > I use kernel 2.6.8.1 I can't write CD by LITE-ON COMBO SOHC-5232K
> > > > revision NK05, but I can write by revision NK0A.
> > > 
> > > Well, upgrade the buggy firmware then? Follow-ups should go to the
> > > cdrecord list, this is not a kernel issue.
> > > 
> > 
> > Thank you man. I can write CD on 2.6.8.1 now...
> > 
> > Remark.. NK05 can write on 2.6.7..
> 
> I am seeing similar problems with a Pioneer DVD writer on 2.6.8.1.  2.6.7 
> can burn discs fine.  2.6.8.1 it does not even recognise it as a writable 
> drive.
> 
> I am wondering if this relates to other write problems I have seen 
> reported for 2.6.8.1 involving music tracks.

It has to do with 2.6.8.1 having a stupid filter for SCSI commands.
Either run the program as root, or upgrade to 2.6.9-rc2.

-- 
Jens Axboe

