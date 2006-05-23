Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWEWOri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWEWOri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWEWOri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:47:38 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:9706 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932148AbWEWOrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:47:37 -0400
From: Julian Seward <julian@valgrind.org>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: Linux Kernel Source Compression
Date: Tue, 23 May 2006 15:47:31 +0100
User-Agent: KMail/1.8.2
Cc: Ivan Novick <ivan@0x4849.net>, Nuri Jawad <lkml@jawad.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0605211028100.4037@p34> <1148393727.14381.262121289@webmail.messagingengine.com> <20060523142302.GA45392@dspnet.fr.eu.org>
In-Reply-To: <20060523142302.GA45392@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605231547.32420.julian@valgrind.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> bzip1 uses arithmetic encoding which is heavily patented.  bzip2 uses
> huffman instead, which isn't, but is slightly (10% is often quoted)
> less efficient.

It uses an adaptive huffman scheme devised by David Wheeler, which usually
gets within 1% of the arithmetic coder that bzip1 used.

bzip2, especially the 1.0.X series, is superior to bzip1 in terms of speed,
memory use, robustness against bad-case inputs, recoverability of data 
from damaged compressed streams, and that it can be used as a library.
Moving back to bzip1 would IMO be a big step backwards.

J
