Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276654AbRJKSZV>; Thu, 11 Oct 2001 14:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276665AbRJKSZB>; Thu, 11 Oct 2001 14:25:01 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:5770 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276654AbRJKSY6>;
	Thu, 11 Oct 2001 14:24:58 -0400
Date: Thu, 11 Oct 2001 14:25:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Guest section DW <dwguest@win.tue.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 loses sda9
In-Reply-To: <20011011202242.A7283@win.tue.nl>
Message-ID: <Pine.GSO.4.21.0110111424520.24742-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001, Guest section DW wrote:

> On Thu, Oct 11, 2001 at 01:07:22AM -0400, Alexander Viro wrote:
> 
> > If you have sfdisk, sfdisk /dev/sda -O /tmp/foo + mailing the result would
> > make debugging the thing much simpler (that one - from the 2.4.10).
> 
> Probably you mean sfdisk -d /dev/sda > /tmp/foo or so?
> My favourite tends to be sfdisk -l -uS -x /dev/sda
> 
> The -O option saves the sectors that are changed by the sfdisk call
> to some file, so that a later undo is possible.

... and the contents of these sectors is precisely what I would like to see.

