Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTLPUhQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 15:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTLPUhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 15:37:16 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:38864 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262081AbTLPUhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 15:37:15 -0500
Date: Tue, 16 Dec 2003 12:37:09 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jean-Luc Fontaine <jfontain@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions statistics question
Message-ID: <20031216203709.GB1402@matchmail.com>
Mail-Followup-To: Jean-Luc Fontaine <jfontain@free.fr>,
	linux-kernel@vger.kernel.org
References: <3FDF5E6A.7010201@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDF5E6A.7010201@free.fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 16, 2003 at 08:35:06PM +0100, Jean-Luc Fontaine wrote:
> (24566 - 7925) = 16641 were written, whereas
> (23567 - 7152) = 16415 were read
> I would have expected something near 1048576 (kilobytes),
> but the results seem to be roughly 64 times less...
> 
> I would really appreciate an explanation, as I use those statistics
> in a monitoring program and for filesystems performance tests.
> 
> Many thanks for your help!
> 

check out the man page for iostat in the sar/sysstat package.  It documents
what is happening here.   This is in blocks, and there is merging to
consider and etc...

> -- 
> Jean-Luc Fontaine  mailto:jfontain@free.fr  http://jfontain.free.fr/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
