Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266056AbUBKSoU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUBKSoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:44:20 -0500
Received: from cs24243203-239.austin.rr.com ([24.243.203.239]:44041 "EHLO
	raptor.int.mccr.org") by vger.kernel.org with ESMTP id S266056AbUBKSoS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:44:18 -0500
Date: Wed, 11 Feb 2004 12:44:16 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
cc: LINUX KERNEL MAILING LIST <linux-kernel@vger.kernel.org>
Subject: Re: About highmem in 2.6
Message-ID: <116960000.1076525055@[10.1.1.5]>
In-Reply-To: <402A6A98.5020404@wanadoo.es>
References: <402A6A98.5020404@wanadoo.es>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, February 11, 2004 18:47:04 +0100 Luis Miguel García
<ktech@wanadoo.es> wrote:

> When I first installed 2.4, someone told me that if I had 1 gb ram it was
> better to not use highmem because those extra aditional mb was not worth
> the speed penalty of using the feature.
> 
> Sorry for my ignorance (and my sucking english) but must I enable highmem
> now with 2.6? or have it any speed penalty althought?

I don't know if anyone has actually measured the relative performance, but
I'd expect the answer to be the same as 2.4.  There is a small but
measurable performance penalty for enabling highmem which is higher than
the benefit of the extra 128 meg of memory you get when you have 1G.  If
you have more than 1G it's better to enable highmem.

Dave McCracken

