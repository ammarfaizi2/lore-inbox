Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265033AbSKSAB4>; Mon, 18 Nov 2002 19:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265019AbSKSABz>; Mon, 18 Nov 2002 19:01:55 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60658 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265010AbSKSABs>; Mon, 18 Nov 2002 19:01:48 -0500
Date: Mon, 18 Nov 2002 19:09:24 -0500
From: Doug Ledford <dledford@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Alexander Viro <viro@math.psu.edu>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why /dev/sdc1 doesn't show up...
Message-ID: <20021119000924.GD6989@redhat.com>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Alexander Viro <viro@math.psu.edu>,
	Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <Pine.GSO.4.21.0211180403440.23400-100000@steklov.math.psu.edu> <20021118235221.637162C456@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118235221.637162C456@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 10:49:21AM +1100, Rusty Russell wrote:
> In message <Pine.GSO.4.21.0211180403440.23400-100000@steklov.math.psu.edu> you 
> write:
> > Not really.  For case in question (block devices) there is only one path
> > and I'd rather keep it that way, thank you very much.
> 
> See other posting.  This is a fundamental design decision, and it's
> not changing.  Sorry.

Then you'll have to back out the patch to module.c because it's already 
changed.


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
