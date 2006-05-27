Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWE0CTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWE0CTL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 22:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWE0CTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 22:19:11 -0400
Received: from quechua.inka.de ([193.197.184.2]:56518 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751763AbWE0CTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 22:19:11 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060525201347.GA21926@csclub.uwaterloo.ca>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FjoOT-0003VO-00@calista.eckenfels.net>
Date: Sat, 27 May 2006 04:19:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> would ever want to do so).  Putting the FQDN as my hostname, makes
> hostname -f act very strange.  I think a number of tools think doing it
> is wrong.

no hostname -f will deal well with a FQDN gethostname() as long as your
resolver (i.e. /etc/hosts) is setup according to the man page:

> hostname -fv
gethostname()='calista.eckenfels.net'
Resolving 'calista.eckenfels.net' ...
Result: h_name='calista.eckenfels.net'
Result: h_aliases='calista'
Result: h_aliases='eckenfels.net'
Result: h_addr_list='10.0.0.3'
calista.eckenfels.net

Gruss
Bernd
