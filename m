Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWGSPmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWGSPmu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWGSPmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:42:49 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:934 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030190AbWGSPmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:42:49 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: George Nychis <gnychis@cmu.edu>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
Date: Wed, 19 Jul 2006 17:42:32 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Chua <jchua@fedex.com>, lkml <linux-kernel@vger.kernel.org>
References: <30DF6C25102A6E4BBD30B26C4EA1DCCC0162E099@MEMEXCH10V.corp.ds.fedex.com> <200607190005.02351.rjw@sisk.pl> <44BE4FB7.5050108@cmu.edu>
In-Reply-To: <44BE4FB7.5050108@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607191742.32609.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 July 2006 17:28, George Nychis wrote:
> Oh, and what should the default resume partition be (for
> CONFIG_SOFTWARE_SUSPEND)? my root partition?

No, your swap partition, but you don't need to set it.

It can also be passed to the kernel with the resume= command line argument.


> Rafael J. Wysocki wrote:
> > On Tuesday 18 July 2006 17:26, George Nychis wrote:
> >> acpid has been started, however there is no /sys/power/disk
> > 
> > Have you set CONFIG_SOFTWARE_SUSPEND in .config?
> > 
> > Rafael
> > 
