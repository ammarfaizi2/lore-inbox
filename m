Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbTDMAze (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 20:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbTDMAze (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 20:55:34 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:27045 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262639AbTDMAzd (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 20:55:33 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jan Knutar <jk-lkml@sci.fi>, "Timothy Miller" <tmiller10@cfl.rr.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Page compression in lieu of swap?
Date: Sun, 13 Apr 2003 11:09:10 +1000
User-Agent: KMail/1.5.1
References: <000d01c30143$ccf54ad0$6801a8c0@epimetheus> <03041303065500.26409@polaris>
In-Reply-To: <03041303065500.26409@polaris>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304131109.10326.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Apr 2003 10:06, Jan Knutar wrote:
> On Sunday 13 April 2003 01:35, Timothy Miller wrote:
> > I did some searching of the kernel archives and the only things
> > related to the forthcoming idea had to do with compressing pages when
> > writing to swap and doing compressed disks.  Here's a different
> > idea...
>
> http://linuxcompressed.sourceforge.net/
>
> This the same thing?

Yes it is and works very well. However it isn't smp or preemptible aware yet. 
I have a patch against -ck* as well, but it isn't popular because of preempt 
incompatibility.

Con
