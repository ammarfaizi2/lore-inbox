Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265024AbUFAQtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbUFAQtt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUFAQtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:49:49 -0400
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:24995 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S265024AbUFAQts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:49:48 -0400
From: jlnance@unity.ncsu.edu
Date: Tue, 1 Jun 2004 12:49:46 -0400
To: Lenar =?unknown-8bit?Q?L=F5hmus?= <lenar@vision.ee>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: why swap at all?
Message-ID: <20040601164946.GA22798@ncsu.edu>
References: <200405290037.17775.vda@port.imtp.ilyichevsk.odessa.ua> <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net> <20040531104928.GA1465@ncsu.edu> <40BC6F0C.7000602@vision.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BC6F0C.7000602@vision.ee>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 02:57:00PM +0300, Lenar L?hmus wrote:
> jlnance@unity.ncsu.edu wrote:
> 
> >I'm not sure.  Copying a file is a pretty good indication that you
> >are about to do something with either the new or the old file.
> >
> Like taking the new file with me on USB dongle and deleting old one? 
> Caching the file really doesn't help in this case.

No, it does not help in this case.

Not putting things in cache is a solution for the problem of
having useful stuff pushed out of the cache.  However, fixing
the problem this way may create other problems if it causes
us to fail to put useful things into the cache.

The point I was trying (perhaps unsuccessfully) to make, is
that we should be careful about not caching things.  We are
likely to break other corner cases by fixing the ones we
are discussing.

Thanks,

Jim
