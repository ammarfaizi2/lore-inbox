Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275255AbTHMQbR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 12:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275269AbTHMQbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 12:31:17 -0400
Received: from mail.gondor.com ([212.117.64.182]:20747 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S275255AbTHMQbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 12:31:16 -0400
Date: Wed, 13 Aug 2003 18:31:06 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rossb@google.com
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Message-ID: <20030813163106.GA2664@gondor.com>
References: <20030806150335.GA5430@gondor.com> <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk> <20030813005057.A1863@pclin040.win.tue.nl> <200308130221.26305.bzolnier@elka.pw.edu.pl> <20030813080309.GB2006@gondor.com> <1060773360.8009.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060773360.8009.11.camel@localhost.localdomain>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 12:16:09PM +0100, Alan Cox wrote:
> That sounds about right for UDMA33, which is what you'd get without the
> fix I sent Marcelo a few days ago

You meant the .id -> .present change, right? I applied this patch, and
still get only 20MB/s.

But I also have some good news: The patch by Ross Biro, available from
http://marc.theaimsgroup.com/?l=linux-kernel&m=104250818527780&w=2
actually fixed the hdparm -I crash.

Jan

