Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbTDXVYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbTDXVXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:23:51 -0400
Received: from palrel12.hp.com ([156.153.255.237]:11663 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264464AbTDXVXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:23:13 -0400
Date: Thu, 24 Apr 2003 14:35:18 -0700
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, davem@redhat.com,
       kuznet@ms2.inr.ac.ru
Subject: Re: [BUG 2.5.X] pipe/fcntl/F_GETFL/F_SETFL obvious kernel bug
Message-ID: <20030424213518.GA18489@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030424183313.GA17374@bougret.hpl.hp.com> <20030424142306.4510d10f.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424142306.4510d10f.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 02:23:06PM -0700, Andrew Morton wrote:
> Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:
> >
> > 	Hi,
> > 
> > 	I reported this obvious kernel 2.5.X bug 6 months ago, and as
> > of 2.5.67 it is still not fixed. Do you know who I should send this
> > bug report to ?
> 
> fcntl(fd, F_GETFL, intp) does not put the return value into *intp.  The
> flags are in fcntl()'s return value.  Same with 2.4.

	*blush*. Thanks for the quick and precise answer, and sorry
about the noise.

	Jean
