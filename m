Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129797AbRBYVrv>; Sun, 25 Feb 2001 16:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129806AbRBYVrb>; Sun, 25 Feb 2001 16:47:31 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:58179 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S129797AbRBYVra>;
	Sun, 25 Feb 2001 16:47:30 -0500
Message-ID: <20010225224729.A16353@win.tue.nl>
Date: Sun, 25 Feb 2001 22:47:29 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: aj@dungeon.inka.de (Andreas Jellinghaus), linux-kernel@vger.kernel.org
Subject: Re: partition table: chs question
In-Reply-To: <20010225163534.A12566@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010225163534.A12566@dungeon.inka.de>; from Andreas Jellinghaus on Sun, Feb 25, 2001 at 04:35:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 04:35:34PM +0100, Andreas Jellinghaus wrote:

> for partitions not in the first 8gb of a harddisk, what
> should the c/h/s start and end value be ?
> 
> most fdisks seem to set start and end to 255/63/1023.
> but partition magic creates partitions with start set to
> 0/1/1023 and end set to 255/63/1023, and detects a problem
> if start is set to 255/63/1023.
> 
> so, how should a partition table look like ?

Since these values will never be used you can imagine that they
are not of great interest. Do whatever you like.
