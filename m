Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269120AbRGaAZS>; Mon, 30 Jul 2001 20:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269117AbRGaAZJ>; Mon, 30 Jul 2001 20:25:09 -0400
Received: from pD951F41A.dip.t-dialin.net ([217.81.244.26]:3592 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S267908AbRGaAYx>; Mon, 30 Jul 2001 20:24:53 -0400
Date: Tue, 31 Jul 2001 02:25:00 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010731022500.E28253@emma1.emma.line.org>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200107301711.f6UHBWHE001945@acap-dev.nas.cmu.edu> <Pine.LNX.4.33L.0107301422120.5582-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0107301422120.5582-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Rik van Riel wrote:

> > Thus BSD fsync() actually guarantees that when it returns, the file
> > (and all of it's filenames) will survive a reboot.
> 
> Note that this is very different from the "link() should be
> synchronous()" mantra we've been hearing over the last days.

Indeed, but this might still require MTA fixing probably, and opening a
file you just want to rename is quite expensive an operation.

-- 
Matthias Andree
