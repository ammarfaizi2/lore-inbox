Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWGKT4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWGKT4B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWGKT4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:56:01 -0400
Received: from [212.33.164.213] ([212.33.164.213]:58642 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932118AbWGKT4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:56:00 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Commenting out out_of_memory() function in __alloc_pages()
Date: Tue, 11 Jul 2006 22:57:12 +0300
User-Agent: KMail/1.5
References: <BKEKJNIHLJDCFGDBOHGMEEJMDCAA.abum@aftek.com> <Pine.LNX.4.64.0607111025320.19812@turbotaz.ourhouse>
In-Reply-To: <Pine.LNX.4.64.0607111025320.19812@turbotaz.ourhouse>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607112257.12311.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:
> On Tue, 11 Jul 2006, Abu M. Muttalib wrote:
> > I fail to understand that why the OS doesn't return NULL as per man
> > pages of malloc. It insteat results in OOM.
>
> If you want strict malloc(), you can use the sysctl to turn off
> overcommit. It's even appropriate to do so for certain applications.

The problem is, there is no way to turn off overcommit completely.

Arjan said something about shared libs depending on overcommit :(

Thanks!

--
Al

