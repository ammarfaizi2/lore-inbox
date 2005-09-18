Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbVIRHel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVIRHel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 03:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVIRHel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 03:34:41 -0400
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:60056 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S1751320AbVIRHel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 03:34:41 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Segfaults in mkdir under high load. Software or hardware?
Date: Sun, 18 Sep 2005 08:34:39 +0100
User-Agent: KMail/1.8.2
References: <mailman.3.1123153201.10574.linux-kernel-daily-digest@lists.us.dell.com> <a0623096fbf5261b770eb@[129.98.90.227]>
In-Reply-To: <a0623096fbf5261b770eb@[129.98.90.227]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509180834.39596.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 September 2005 01:20, Maurice Volaski wrote:
>
> I have been seeing a similar thing:
>
> ./current:Sep 17 18:00:01 [kernel] mkdir[7696]: segfault at
> 0000000000000000 rip 000000000040184d rsp 00007fffff826350 error 4
>
> I'm using the plain 2.6.13 (from gentoo vanilla sources), though it
> was compiled with
> gcc version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)

x86_64 ? If so see http://bugzilla.kernel.org/show_bug.cgi?id=4851

Andrew
