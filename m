Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTLJFtM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 00:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTLJFtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 00:49:12 -0500
Received: from mail.kroah.org ([65.200.24.183]:49074 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261877AbTLJFtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 00:49:11 -0500
Date: Tue, 9 Dec 2003 21:42:54 -0800
From: Greg KH <greg@kroah.com>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Holger Schurig <h.schurig@mn-logistik.de>, linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031210054253.GA1982@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com> <1070953338.7668.6.camel@simulacron> <20031209071303.GB24876@Master.launchmodem.com> <br41h9$mth$1@sea.gmane.org> <20031209171047.GA29799@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209171047.GA29799@mark.mielke.cc>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 12:10:47PM -0500, Mark Mielke wrote:
> On Tue, Dec 09, 2003 at 09:21:56AM +0100, Holger Schurig wrote:
> > Devfs for embedded devices is just great. It's all in the kernel, no
> > external process to run (I use my embedded stuff without devfsd). I'm using
> > it for about one year with various kernels.
> 
> I don't see why 'all in the kernel' is the best approach, embedded or
> otherwise. I believe udev is being written to execute with a minimal
> runtime environment. No glibc, or other such beasts.

Exactly.  The current bk tree version of udev (which has more features
than the 008 release) is weighing in at 49Kb, linked statically, no
external dependancies.

greg k-h
