Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTKKU5Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 15:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263747AbTKKU5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 15:57:16 -0500
Received: from unthought.net ([212.97.129.88]:60906 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S263732AbTKKU5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 15:57:13 -0500
Date: Tue, 11 Nov 2003 21:57:12 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031111205711.GE25828@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <QiyV.1k3.15@gated-at.bofh.it> <3FAF7FC8.8050503@softhome.net> <03111007291500.08768@tabby> <20031110142222.GA21220@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031110142222.GA21220@nevyn.them.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 09:22:22AM -0500, Daniel Jacobowitz wrote:
> On Mon, Nov 10, 2003 at 07:29:15AM -0600, Jesse Pollard wrote:
> > Now back to the copy.. You don't have to use a read/write loop- mmap
> > is faster. And this is the other reason for not doing it in Kernel mode.
> 
> Actually, last I checked, read/write was actually faster.  Linus
> explained why a month or two ago.

It would also not break on large files...

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
