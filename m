Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288327AbSACVif>; Thu, 3 Jan 2002 16:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288324AbSACVi0>; Thu, 3 Jan 2002 16:38:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16658 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288327AbSACViQ>; Thu, 3 Jan 2002 16:38:16 -0500
Date: Thu, 3 Jan 2002 13:37:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Urban Widmark <urban@teststation.com>
cc: Dave Jones <davej@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] smbfs fsx'ed
In-Reply-To: <Pine.LNX.4.33.0201031306240.26000-100000@cola.teststation.com>
Message-ID: <Pine.LNX.4.33.0201031335150.2216-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Jan 2002, Urban Widmark wrote:
>
> Patch vs 2.5.2-pre5, but should work for 2.5.2-pre6 and 2.5.1-dj11.
> Please apply.

Applied.

Btw, Urban, is anybody working on trying to do "{read|write}page()"
asynchronously? I assume that IO performance on smbfs must be quite
horrible with totally synchronous IO..

(Not as horrible as the NCPFS thing that doesn't understand about the page
cache at all, but still..)

		Linus

