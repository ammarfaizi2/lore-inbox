Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264706AbUE0Rik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264706AbUE0Rik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUE0Rik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:38:40 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:54925 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264706AbUE0Rii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:38:38 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Subject: Re: AMD64: IDE performance woes
Date: Thu, 27 May 2004 19:40:27 +0200
User-Agent: KMail/1.5.3
References: <1085678259.3374.7.camel@hostmaster.org>
In-Reply-To: <1085678259.3374.7.camel@hostmaster.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405271940.27702.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 of May 2004 19:17, Thomas Zehetbauer wrote:
> It seems that IDE performance is severely degraded on AMD64:
>
> hdparm -t timings
> 2.4.25/i386:  54.13MB/s
> 2.6.6/x86_64: 31.4MB/s
>
> Board is a Tyan Thunder K8W s2885 with an AMD8111 controller
> IDE device parameters are the same (hdparm -a8 -c1 -d1 -m16 -u1)

Can you try with -a8 removed?

> Tom

