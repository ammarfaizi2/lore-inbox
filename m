Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTE3Qi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 12:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTE3Qi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 12:38:57 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:48078 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263800AbTE3Qi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 12:38:56 -0400
Date: Fri, 30 May 2003 18:52:11 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Duncan Laurie <duncan@sun.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, kwijibo@zianet.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 21rc6 serverworks IDE blows even more than is usual :)
Message-ID: <20030530165211.GB21714@louise.pinerecords.com>
References: <20030529114001.GD7217@louise.pinerecords.com> <20030529114001.GD7217@louise.pinerecords.com> <20030530121108.6a6a82de.skraw@ithnet.com> <oprpzvr4xuury4o7@lists.bilicki.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oprpzvr4xuury4o7@lists.bilicki.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [duncan@sun.com]
> 
> On Fri, 30 May 2003 12:11:08 +0200, Stephan von Krawczynski 
> <skraw@ithnet.com> wrote:
> >
> >I don't know if this is in anyway interesting for you, but I got the same
> >chipset on an Asus board and been burning GBs of data onto DVDs with it 
> >and no
> >(ide) problem.
> >
> 
> Its interesting to me.. It probably means my original diagnosis that this
> was a bad chip revision is unfounded and maybe it can be fixed with the
> right settings.  Could I get an lspci -xxx for devices 00:0f.0 and 00:0f.1
> from your box as well so I can cross-ref it with the broken ones?

Duncan, your assumption is quite correct.  I got the thing working.

Don't even ask.  "/sbin/hdparm -X69 -d1" was the formula.

Oh well.

-- 
Tomas Szepe <szepe@pinerecords.com>
