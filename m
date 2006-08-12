Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWHLL7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWHLL7q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 07:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWHLL7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 07:59:46 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:35154 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S964822AbWHLL7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 07:59:45 -0400
Message-ID: <44DDC2A5.6020802@tls.msk.ru>
Date: Sat, 12 Aug 2006 15:59:33 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-raid <linux-raid@vger.kernel.org>, Neil Brown <neilb@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug?] raid1 integrity checking is broken on 2.6.18-rc4
References: <200608120252_MC3-1-C7DD-BA91@compuserve.com> <Pine.LNX.4.64.0608120512440.21701@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0608120512440.21701@p34.internal.lan>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> Is there a doc for all of the options you can echo into the sync_action?
> I'm assuming mdadm does these as well and echo is just another way to
> run work with the array?

How about the obvious, Documentation/md.txt ?

And no, mdadm does not perform or trigger data integrity checking.

/mjt
