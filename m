Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWANIYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWANIYj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 03:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWANIYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 03:24:39 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:19898 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750709AbWANIYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 03:24:39 -0500
From: Grant Coady <gcoady@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4: e100 accounting bust for multiple adapters
Date: Sat, 14 Jan 2006 19:24:34 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <5dbhs11efpi4ho3mciism8ppvt23pb7h53@4ax.com>
References: <e196s1pj6u4apbjhgdm3imij4a10s6nb87@4ax.com> <4807377b0601101624m1e1eb636q99ae0792b0903c5a@mail.gmail.com> <cln8s1diqmsei30gqo0dbuv1hclgl4m2lu@4ax.com> <4807377b0601112059je92091ch73f3788aeca452ce@mail.gmail.com> <53pgs11trhj0f6ik29hk41n4p5fegbft55@4ax.com> <4807377b0601132350y41c47d3bpb46b7b9af3690038@mail.gmail.com>
In-Reply-To: <4807377b0601132350y41c47d3bpb46b7b9af3690038@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006 23:50:38 -0800, Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:

>we've taken the position that 2.4 is legacy and if it ain't broke
>don't fix it.
Okay.

Had a look at the source but it is difficult to track the indirection, 
I gave up ;)  After all, performance-wise the old driver is okay, just 
odd accounting.  Annoying to know there's a missing (harmless) indirection
in the module case but I don't have a clue where to look for it.


>I'm hoping you can get along with the 3.X driver, and I'll be glad to
>look into any issues that you come up with for that driver.

Minor nit: lsmod shows zero when two e100-3.5.10 in use.  

Grant.
