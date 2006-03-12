Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWCLDld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWCLDld (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 22:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWCLDld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 22:41:33 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20191 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751293AbWCLDlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 22:41:32 -0500
Subject: Re: Patch: MSI-K8T-Neo2-Fir OnboardSound and additional Soundcard
From: Lee Revell <rlrevell@joe-job.com>
To: Johannes Goecke <goecke@upb.de>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060311192840.GA19313@uni-paderborn.de>
References: <20060311192840.GA19313@uni-paderborn.de>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 22:41:29 -0500
Message-Id: <1142134890.25358.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 20:28 +0100, Johannes Goecke wrote:
> - how to enshure that the code is executed ONLY on excactly this kind
> of boards
>  (not any other with similar Chipset)?
> 
> - what to do to (hopefully) integrate that pice of code into
>   one of the next Kernel Releases?
> 

This has been discussed on LKML recently, it's not 2.6.16 material
because it might break working setups when the previously disabled
device becomes the default sound card.  Of course the same setup would
have broken if we added a driver for a previously unsupported soundcard,
so I'm not sure how this fits in with the "don't break userspace" rule.

IMHO it should be merged post 2.6.16.

Lee

