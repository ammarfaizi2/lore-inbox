Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263773AbTEOD0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbTEOD0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:26:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13068 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263773AbTEODYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:24:48 -0400
Date: Wed, 14 May 2003 20:37:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: davej@codemonkey.org.uk
cc: linux-kernel@vger.kernel.org, <gregkh@kroah.com>
Subject: Re: mysterious shifts in USB storage drivers.
In-Reply-To: <200305150331.h4F3VHID000770@deviant.impure.org.uk>
Message-ID: <Pine.LNX.4.44.0305142036140.28644-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 May 2003 davej@codemonkey.org.uk wrote:
>
> These went into 2.4 over a year ago. Unfortunatly,
> with no comments in the logs.

There's a lot more of these than the two this patch fixes. Just do a grep 
for CHECK_COND in storage/*.c. 

Patch dropped pending further explanation of why these two cases would be 
special.

		Linus

