Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTLEHjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 02:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbTLEHjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 02:39:04 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:28134 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S263902AbTLEHjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 02:39:01 -0500
From: Duncan Sands <baldrick@free.fr>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Fri, 5 Dec 2003 08:38:58 +0100
User-Agent: KMail/1.5.4
Cc: fuzzy77@free.fr, mfedyk@matchmail.com, zwane@holomorphy.com,
       linux-kernel@vger.kernel.org
References: <3FC4E8C8.4070902@free.fr> <200312041214.33376.baldrick@free.fr> <20031204085704.12d398df.rddunlap@osdl.org>
In-Reply-To: <20031204085704.12d398df.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312050838.58349.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 December 2003 17:57, Randy.Dunlap wrote:
> On Thu, 4 Dec 2003 12:14:33 +0100 Duncan Sands <baldrick@free.fr> wrote:
> | > EIP is at releaseintf+0x62/0x80 [usbcore]
> |
> | I haven't found time to work on this, sorry -
> | I'm really busy with my real jobs right now.
> |
> | > <0>Fatal exception: panic in 5 seconds
> |
> | What is this, by the way?  I never saw it.
>
> That comes from setting the sysctl "panic_on_oops" so that an oops
> goes straight to a panic condition.

That explains why this relatively harmless Oops was
freezing Vince's box.  I guess he should turn it off.

Thanks for the info,

Duncan.
