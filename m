Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269478AbRGaVaD>; Tue, 31 Jul 2001 17:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269475AbRGaV3x>; Tue, 31 Jul 2001 17:29:53 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:16654 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269479AbRGaV3k>; Tue, 31 Jul 2001 17:29:40 -0400
Date: Tue, 31 Jul 2001 23:29:47 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010731232947.C13258@emma1.emma.line.org>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010731032104.O2650@mea-ext.zmailer.org> <Pine.LNX.4.33L.0107302219340.5582-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0107302219340.5582-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Rik van Riel wrote:

> > I didn't check if POSIX folks have thought of that.
> 
> Nice addition.  Easier to use than fsync() - no need to
> open the file - and probably easier to implement in the
> kernel because this way we'll be handing the whole path
> to the kernel, whereas fsync() would have the dubious
> task of finding out how this file can be traced all the
> way down from the root of the filesystem.

If I understand SUS v2 correctly, fsync() must sync meta data
corresponding to the file.

If Linux ext2 doesn't to that, it might be a good idea to change that so
it does.

-- 
Matthias Andree
