Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbTH2QUh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTH2QUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:20:37 -0400
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:1552 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261434AbTH2QUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:20:32 -0400
Date: Fri, 29 Aug 2003 18:21:32 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       sensors@Stimpy.netroedge.com, vsu@altlinux.ru
Subject: Re: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
Message-Id: <20030829182132.29c3ac55.khali@linux-fr.org>
In-Reply-To: <1062033440.16799.22.camel@dooby.cs.berkeley.edu>
References: <20030803192312.68762d3c.khali@linux-fr.org>
	<20030804193212.11786d06.vsu@altlinux.ru>
	<20030805103240.02221bed.khali@linux-fr.org>
	<20030805210704.GA5452@kroah.com>
	<20030806100702.78298ffe.khali@linux-fr.org>
	<1060886657.1006.7121.camel@dooby.cs.berkeley.edu>
	<20030814190954.GA2492@kroah.com>
	<1060912895.1006.7160.camel@dooby.cs.berkeley.edu>
	<20030815211329.GB4920@kroah.com>
	<1062033440.16799.22.camel@dooby.cs.berkeley.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here's the patch against 2.6.0-test4.  Just to remind everyone, this
> patch doesn't fix any bugs (they're already fixed in 2.6.0-test3), it
> just makes the code pass our static analysis tool, cqual, without
> generating a warning.  Since finding and fixing these bugs is so
> tricky, it seems worthwhile to have code which can be automatically
> verified to be bug-free (at least w.r.t. user/kernel pointers). 
> That's what this patch is about.  Let me know if you have any
> questions or comments. Thanks for everyone's help.

If I read the patch correctly, this is basically a kind of reversal to
your original patch, before Sergey and I changed it?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
