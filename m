Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUJLR5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUJLR5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUJLRxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:53:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36504 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267591AbUJLRtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:49:03 -0400
Date: Tue, 12 Oct 2004 10:48:48 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Oleksiy <Oleksiy@kharkiv.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       zaitcev@redhat.com
Subject: Re: pl2303/usb-serial driver problem in 2.4.27-pre6
Message-ID: <20041012104848.530a5be7@lembas.zaitcev.lan>
In-Reply-To: <20041011113609.GB417@logos.cnet>
References: <416A6CF8.5050106@kharkiv.com.ua>
	<20041011113609.GB417@logos.cnet>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs119.1 (GTK+ 2.4.7; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004 08:36:09 -0300
Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> Pete, 
> 
> I bet this has been caused by your USB changes?

> > [...] So i decided to test all 
> > kernels between 2.4.26 and 2.4.28-pre4 (also not working). Link works 
> > well in 2.4.27-pre5 and stop working in 2.4.27-pre6.

I'm afraid you're right, because Oleksiy did the bisection. However,
I cannot see how this is possible. In fact, it fixed ppp for a few
people...

This may be something pl2303 specific. I'll work with Oleksiy to get
to the bottom of it.

-- Pete
