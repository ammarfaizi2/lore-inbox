Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272168AbTHDUJh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272222AbTHDUJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:09:37 -0400
Received: from almesberger.net ([63.105.73.239]:34309 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S272168AbTHDUJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:09:33 -0400
Date: Mon, 4 Aug 2003 17:09:21 -0300
From: Werner Almesberger <werner@almesberger.net>
To: David Lang <david.lang@digitalinsight.com>
Cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TOE brain dump
Message-ID: <20030804170921.O5798@almesberger.net>
References: <20030804165649.N5798@almesberger.net> <Pine.LNX.4.44.0308041259220.7534-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308041259220.7534-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Mon, Aug 04, 2003 at 01:01:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> I would think that it's much more difficult to run NUMA across different
> types of CPU's

I'd view this as a new and interesting challenge :-) Besides,
if one would use Alan's idea, and just use an amd64, or such,
the CPUs wouldn't be all that different in the end.

One added benefit of using similar CPUs would be that also
bits of user space (e.g. a copy loop) could migrate to the
NIC.

> then it would be to run a seperate kernel on the NIC.

Yes, but that separate kernel would need new administrative
interfaces, and things like route changes would be difficult
to handle. (That is, if you still want this to appear as a
single system to user space.) It would certainly be better
that running a completely proprietary solution, but you still
get a few nasty problems.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
