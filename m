Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWHGPgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWHGPgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWHGPgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:36:51 -0400
Received: from homer.mvista.com ([63.81.120.158]:51379 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932155AbWHGPgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:36:50 -0400
Subject: Re: Call Trace: 2.6.17-rt5: Call Trace:
	<ffffffff802500fd>{out_of_memory+55}
From: Daniel Walker <dwalker@mvista.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <5bdc1c8b0608070819w653368cm82112655a7b98ec4@mail.gmail.com>
References: <5bdc1c8b0608070819w653368cm82112655a7b98ec4@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 08:36:45 -0700
Message-Id: <1154965007.18476.34.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 08:19 -0700, Mark Knecht wrote:
> Hi all,
>    I've never seen this on 2.6.17-rt5. Up until today it had always
> been quite stable. I was running MythTV at the time. Nothing out of
> the ordinary.

Those message are cause by the system running out of memory. I've see
MythTV make the system run out of memory on non-RT kernels (must be a
memory leak someplace). So I wouldn't think it related to any real time
changes.

>    Excuse my lack of experience here but after an event like this what
> is the proper way to make sure the kernel is as stable as it can be?
> Do I need to clean anything up? Reboot? Or is the cleanup all
> automatic and everything is fine?

The kernel will kill some running user space tasks to free memory. But
the kernel should be fine after that.

Daniel 

