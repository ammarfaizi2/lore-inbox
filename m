Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWDCMf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWDCMf3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 08:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWDCMf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 08:35:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:42429 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751524AbWDCMf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 08:35:28 -0400
Date: Mon, 3 Apr 2006 18:09:59 +0530
From: Rachita Kothiyal <rachita@in.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm2 fails to boot on a x86_64 box
Message-ID: <20060403123959.GA19351@in.ibm.com>
Reply-To: rachita@in.ibm.com
References: <20060403070643.GA18648@in.ibm.com> <200604031159.49953.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604031159.49953.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 11:59:49AM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday 03 April 2006 09:06, Rachita Kothiyal wrote:
> > I was trying to boot to a 2.6.16-mm2 kernel on a
> > x86_64 machine, but the kernel panic'd with the
> > attached output.
> > 
> > Any ideas?
> 
> I'd try to change the I/O scheduler and see what happens.  If it works,
> the CFQ is probably at falut.

Hi

I tried using deadline, as and noop as IO schedulers instead of cfq
and they all seemed to work fine. The system now boots up fine.

Thanks
Rachita
