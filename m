Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTLBSxm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbTLBSxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:53:42 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:38417
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264324AbTLBSxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:53:40 -0500
Date: Tue, 2 Dec 2003 10:53:33 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Tomas Konir <moje@vabo.cz>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031202185333.GV1566@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Tomas Konir <moje@vabo.cz>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <200312011226.04750.nbensa@gmx.net> <20031202115436.GA10288@physik.tu-cottbus.de> <20031202120315.GK13388@conectiva.com.br> <Pine.LNX.4.58.0312021402360.17892@moje.vabo.cz> <20031202131512.GU13388@conectiva.com.br> <Pine.LNX.4.58.0312021433360.8417@moje.vabo.cz> <20031202135423.GB13388@conectiva.com.br> <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 03:21:54PM -0500, Tomas Konir wrote:
> 2.6 is still unstable now. I'm using -test10 on my workstation, but it 
> takes minimally an half year to use it on server. I can't use ext3 on 
> server, because of missing features such as ACL, dump (with acl's), 
> built in qouta and for last much different speed on SMP machine.

You have all of that for ext3 in 2.6.  The locking has been improved, there
is acl support, and quota has been there for a long time (even in 2.4).  I'm
not sure about the dump, but if dump gets all allocated blocks, then you
should have ACLs dumped too.

