Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQKAUQm>; Wed, 1 Nov 2000 15:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129713AbQKAUQd>; Wed, 1 Nov 2000 15:16:33 -0500
Received: from [62.172.234.2] ([62.172.234.2]:50757 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129055AbQKAUQ0>;
	Wed, 1 Nov 2000 15:16:26 -0500
Date: Wed, 1 Nov 2000 20:16:35 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Jean-Francois Patenaude <jf.patenaude@bell.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel panic while copying files
In-Reply-To: <3A00400D.4981E278@bell.ca>
Message-ID: <Pine.LNX.4.21.0011012012580.5182-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Francois,

You are reporting a panic but missing the most important ingredient:

On Wed, 1 Nov 2000, Jean-Francois Patenaude wrote:
> [5.] Output of Oops.. message (if applicable) with symbolic information 
>      resolved (see Documentation/oops-tracing.txt)
> 
> xx
> 

If "xx" means "kiss-kiss" then you can "kiss good bye" to any hope of
resolving this panic until you send the oops message passed through
ksymoops. If this is really a panic and not an oops then you need to
capture it through a serial console and then pass through ksymoops on the
next boot.

Regards,
Tigran


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
