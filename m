Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTJOQOp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbTJOQOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:14:45 -0400
Received: from azgamers.com ([68.98.208.145]:31628 "HELO azgamers.com")
	by vger.kernel.org with SMTP id S263479AbTJOQOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:14:44 -0400
From: "Matt H." <lkml@lpbproductions.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: incoming packet latency in 2.4.[18-20]
Date: Wed, 15 Oct 2003 09:15:56 -0700
User-Agent: KMail/1.5.9
References: <3F8D6BB0.7060809@nortelnetworks.com>
In-Reply-To: <3F8D6BB0.7060809@nortelnetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310150915.56857.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tried a more recent kernel?

Matt H.

On Wednesday 15 October 2003 08:45 am, Chris Friesen wrote:
> There is an issue with incoming packet latency in the kernels mentioned.
>
> It seems that if you send in a burst of messages, the amount of time it
> takes to wake the listening process is dependent on the size of the
> message burst.  2.4.18-2.4.20 all show this behaviour, 2.6 doesn't.
>
> Some numbers for a udp message size of 2 bytes:
>
> 1 packet, average latency 12 usecs
> 10 packets, average latency 66 usecs
> 100 packets, average latency 477 usecs
>
> Is this a known issue?  Is there an easy way to fix this, or is it
> something inherent in the 2.4 architecture?
>
> Thanks,
>
> Chris
