Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbTFLAvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 20:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264646AbTFLAvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 20:51:11 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:32818 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264643AbTFLAvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 20:51:09 -0400
Date: Wed, 11 Jun 2003 18:05:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: Greg KH <greg@kroah.com>
Cc: boris@macbeth.rhoen.de, linux-kernel@vger.kernel.org
Subject: Re: oops while booting : 2.5.70-bk1[4,5] - Process swapper
Message-Id: <20030611180548.733eb4bd.akpm@digeo.com>
In-Reply-To: <20030612001931.GB27815@kroah.com>
References: <20030610202947.GA752@macbeth.rhoen.de>
	<20030610143018.025d318c.akpm@digeo.com>
	<20030610165111.7911b7cb.akpm@digeo.com>
	<20030612001931.GB27815@kroah.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 01:04:53.0875 (UTC) FILETIME=[A204EC30:01C3307E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Tue, Jun 10, 2003 at 04:51:11PM -0700, Andrew Morton wrote:
> > 
> > Greg, do you have time/inclination to untangle (and preferably document)
> > this mess?
> 
> Ugh, what a mess.  Hm, no I don't really have the time right now to do
> this, but possibly will after the rest of the pci changes are done...

Thanks.

> As for documenting, why?  It's an arch specific thing that really does
> not get touched very often, if at all.

a) so you can convince yourself that it's right

b) so someone else has a chance of modifying it later without it
   exploding subtly in someone else's face.

