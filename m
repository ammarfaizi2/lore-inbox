Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292964AbSB0Vfj>; Wed, 27 Feb 2002 16:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292979AbSB0Ver>; Wed, 27 Feb 2002 16:34:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:15538 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S292976AbSB0VeG>;
	Wed, 27 Feb 2002 16:34:06 -0500
Date: Wed, 27 Feb 2002 22:29:54 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5.6-pre2] fix task migration code boot hang
In-Reply-To: <200202272117.g1RLHCB05891@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0202272229080.26081-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Feb 2002, James Bottomley wrote:

> The task migration code of change set 1.373 actually only works on
> architectures where the physical and logical CPU numberings are the
> same. It they aren't, the boot sequence hangs forever. The attached
> fixes the code to work on all architectures.

yep. DaveM has sent me a fix for this already which is in my tree.

	Ingo

