Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbTLLQAO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbTLLQAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:00:13 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:4619 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id S265250AbTLLQAI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:00:08 -0500
Date: Fri, 12 Dec 2003 16:00:00 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: matthew@sphinx.mythic-beasts.com
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
In-Reply-To: <yw1xy8tixe96.fsf@kth.se>
Message-ID: <Pine.LNX.4.58.0312121559130.29730@sphinx.mythic-beasts.com>
References: <16345.51504.583427.499297@l.a> <yw1xd6auyvac.fsf@kth.se>
 <Pine.LNX.4.53.0312121000150.10423@chaos> <yw1xy8tixe96.fsf@kth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, Måns Rullgård wrote:

> > It is not a broken BIOS! The BIOS timer that ticks 18.206 times per
> > second has an ISR that, in addition to keeping time, turns OFF the FDC
> > motor after two seconds of inactivity. This ISR is taken away by
> > Linux. Therefore Linux must turn off that motor! It is a Linux bug,
> > not a BIOS bug. Linux took control away from the BIOS during boot.
>
> OK, but why doesn't it affect all machines?

Most likely, other machines take longer than two seconds from
probing the floppy to booting the kernel.

Matthew.
