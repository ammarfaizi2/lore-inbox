Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264731AbUD1Kq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbUD1Kq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 06:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264732AbUD1Kq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 06:46:29 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:18430 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264731AbUD1Kq1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 06:46:27 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: ncunningham@linuxmail.org, "Chris Siebenmann" <cks@utcc.utoronto.ca>
Subject: Re: What does tainting actually mean?
Date: Wed, 28 Apr 2004 12:37:42 +0200
User-Agent: KMail/1.5.3
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <04Apr28.020259edt.41801@gpu.utcc.utoronto.ca> <opr65k5ivcshwjtr@laptop-linux.wpcb.org.au>
In-Reply-To: <opr65k5ivcshwjtr@laptop-linux.wpcb.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404281237.42515.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 of April 2004 08:18, Nigel Cunningham wrote:
> Hi.
>
> On Wed, 28 Apr 2004 02:02:55 -0400, Chris Siebenmann
>
> <cks@utcc.utoronto.ca> wrote:
> >  What happens when a binary module thinks it knows the size of a
> > structure and is wrong? What happens when a binary module has a
> > concurrency problem, in any of the many forms they manifest in the Linux
> > kernel?
>
> Good points. It could be really difficult to trace the cause of those
> issues. But hard/too much effort != impossible. For every entry point to
> the module we have a known state of the system prior to and after the
> call. We could potentially checksum the whole of memory before and after
> and find out exactly what the module has changed.

This is not going to work.  Data structures can and probably will change.

> Anyway, I'm going to drop this conversation now. Work to do :>

Good. :)

