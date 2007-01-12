Return-Path: <linux-kernel-owner+w=401wt.eu-S1161127AbXALWnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbXALWnB (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbXALWnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:43:01 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:40428 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161127AbXALWnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:43:00 -0500
Date: Fri, 12 Jan 2007 23:41:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Moyer <jmoyer@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Steven Fernandez <sfernand@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] raw: don't allow the creation of a raw device with minor
 number 0
In-Reply-To: <x49bql48aus.fsf@segfault.boston.devel.redhat.com>
Message-ID: <Pine.LNX.4.61.0701122341030.19224@yvahk01.tjqt.qr>
References: <x49bql48aus.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 12 2007 11:32, Jeff Moyer wrote:

>Date: Fri, 12 Jan 2007 11:32:11 -0500
>From: Jeff Moyer <jmoyer@redhat.com>
>To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
>Cc: Steven Fernandez <sfernand@redhat.com>, Andrew Morton <akpm@osdl.org>
>Subject: [patch] raw: don't allow the creation of a raw device with minor
>    number 0
>
>Hi,
>
>Minor number 0 (under the raw major) is reserved for the rawctl device
>file, which is used to query, set, and unset raw device bindings.
>However, the ioctl interface does not protect the user from specifying
>a raw device with minor number 0:

No idea what to say about this... probably:

  What:   RAW driver (CONFIG_RAW_DRIVER)
  When:   December 2005
  Why:    declared obsolete since kernel 2.6.3
          O_DIRECT can be used instead
  Who:    Adrian Bunk <bunk@stusta.de>



	-`J'
-- 
