Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbTEFNmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263712AbTEFNmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:42:14 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8320
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263711AbTEFNmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:42:13 -0400
Subject: Re: The 2.6 kernel, expected to be released by late next month
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Colin Paul Adams <colin@colina.demon.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <ltllxk43m6.fsf@colina.demon.co.uk>
References: <freemail.20030406091947.50806@fm9.freemail.hu>
	 <1052220789.28792.37.camel@dhcp22.swansea.linux.org.uk>
	 <ltllxk43m6.fsf@colina.demon.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052225630.1201.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 13:53:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 14:16, Colin Paul Adams wrote:
> >>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
>     Alan> Wildly improbable. 2.6-test maybe, but there are way too
>     Alan> many bugs left including data corruption.
> 
> What sort of data corruption?
> 
> I've just ordered a dual Xeon machine, so I was planning to run 2.5.x
> on it, to maximize throughput, but this sounds worrying. perhaps I'd
> better stick to 2.4.n?

At least as of 2.5.68 floppy corrupts data, and there have been odd (but
not horrifying) problems with IDE that Bart may now have fixed. After
that its a case of going through the noise, figuring out which other
minor corruption reports come from the tty bug, vm races, user error,
bad ram and so on.

I run 2.5.x continually on some non critical boxes. I do have backups 
but even on 2.4 nothing says my disk wont suddenely fail anyway.

A lot of these are corner cases, and crossing off items one at a time,
not "it eats lots of computers"

