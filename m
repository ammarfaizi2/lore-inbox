Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTJXKcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 06:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTJXKcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 06:32:48 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:62427 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261827AbTJXKcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 06:32:47 -0400
Date: Fri, 24 Oct 2003 12:32:45 +0200 (MEST)
From: News Admin <news@nimloth.ics.muni.cz>
Message-Id: <200310241032.h9OAWjPu023912@nimloth.ics.muni.cz>
To: linux-kernel@vger.kernel.org
X-Muni-Spam-TestIP: 147.251.6.10
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From news Fri Oct 24 12:32:45 2003
Received: (from news@localhost)
	by nimloth.ics.muni.cz (8.12.8/8.10.0.Beta12) id h9OAWip7023898
	for newsmaster; Fri, 24 Oct 2003 12:32:44 +0200 (MEST)
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Re: HighPoint 374
Message-ID: <3F98FFCC.480F3109@i.am>
Sender: UNKNOWN@decibel.fi.muni.cz
Date: Fri, 24 Oct 2003 10:32:44 GMT
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
X-Nntp-Posting-Host: decibel.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
References: <3F94FB1B.9000803@kmlinux.fjfi.cvut.cz>
Mime-Version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.23-pre7-pac2 i686)
Organization: unknown

Jindrich Makovicka wrote:
> 
> With my EPoX 8K9A3+, I had to hack the kernel to get the HPT374 running
> at all, as it reported slightly higher PCI clock than 33MHz, although
> the machine wasn't overclocked, but it seems to run fine. The current
> driver supports only 33MHz clock, which is probably the reason HPT374
> isn't even initialized in some cases.

Hi

Hmm I'll had to try your patch - on my now pretty old BP6 box
with HPT370 I could not even boot linux if my box is NOT overclocked.
With standard 400MHz it just stop with some DMA timeouts. 
When I'm using it regulary with 560MHz it works just fine.
Though there are locks form time to time...


-- 
  .''`.
 : :' :    Zdenek Kabelac  kabi@{debian.org, users.sf.net, fi.muni.cz}
 `. `'           Debian GNU/Linux maintainer - www.debian.{org,cz}
   `-

