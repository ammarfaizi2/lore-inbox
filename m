Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWEWQfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWEWQfl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWEWQfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:35:41 -0400
Received: from leitseite.net ([213.239.214.51]:33740 "EHLO mail.leitseite.net")
	by vger.kernel.org with ESMTP id S1750830AbWEWQfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:35:41 -0400
Date: Tue, 23 May 2006 18:35:37 +0200 (CEST)
From: Nuri Jawad <lkml@jawad.org>
X-X-Sender: lkml@pc
To: Julian Seward <julian@valgrind.org>
Cc: Olivier Galibert <galibert@pobox.com>, Ivan Novick <ivan@0x4849.net>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Source Compression
In-Reply-To: <200605231547.32420.julian@valgrind.org>
Message-ID: <Pine.LNX.4.64.0605231658001.28939@pc>
References: <Pine.LNX.4.64.0605211028100.4037@p34>
 <1148393727.14381.262121289@webmail.messagingengine.com>
 <20060523142302.GA45392@dspnet.fr.eu.org> <200605231547.32420.julian@valgrind.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2006, Julian Seward wrote:

> It uses an adaptive huffman scheme devised by David Wheeler, which usually
> gets within 1% of the arithmetic coder that bzip1 used.

If that coder has patent issues, it shouldn't be used, of course, 
regardless of performance.

> bzip2, especially the 1.0.X series, is superior to bzip1 in terms of speed,
> memory use, robustness against bad-case inputs, recoverability of data
> from damaged compressed streams, and that it can be used as a library.

Superior in most aspects, yes, but not regarding compression ratio. 
Anyway, calling bzip2 a step backwards was a bit of provocation and not 
really meant seriously, but it does have slightly reduced compression ratio.

Maybe bzip2 could be updated to make more use of today's fast CPUs? Much 
larger dictionary or other computationally expensive improvements.

Regards, Nuri
