Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbVH2UDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbVH2UDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbVH2UDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:03:24 -0400
Received: from mollusk.mweb.co.za ([196.2.24.27]:4166 "EHLO mollusk.mweb.co.za")
	by vger.kernel.org with ESMTP id S1751493AbVH2UDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:03:23 -0400
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Tim Weippert <weiti@security.tds.de>
Subject: Re: Bad page state on AMD Opteron Dual System with kernel 2.6.13-rc6-git13
Date: Mon, 29 Aug 2005 22:04:05 +0200
User-Agent: KMail/1.7.2
References: <20050826165342.GA11796@pbkg4> <20050829052454.GA8172@pbkg4> <20050829102830.GA7604@pbkg4>
In-Reply-To: <20050829102830.GA7604@pbkg4>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508292204.06032.bonganilinux@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 August 2005 12:28 pm, you wrote:
> Hi,
>

8<

>
> Update, with stable 2.6.13. I get nearly the same behavior.
>

I haven't tried 2.6.13 yet (still downloading), could you first try this (with 
yor last working kernel, since you seem to have a problem with 2.6.13)

echo 0 > /proc/sys/kernel/randomize_va_space

If this "hides" the problems for you, please take a look at this bug report, 
and add your details:

http://bugzilla.kernel.org/show_bug.cgi?id=4851

Regards
