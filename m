Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262008AbRETSpW>; Sun, 20 May 2001 14:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262133AbRETSpM>; Sun, 20 May 2001 14:45:12 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:15373 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262008AbRETSpE>; Sun, 20 May 2001 14:45:04 -0400
Date: Sun, 20 May 2001 11:44:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: add page argument to copy/clear_user_page
In-Reply-To: <15111.38049.614837.978468@tango.paulus.ozlabs.org>
Message-ID: <Pine.LNX.4.21.0105201143560.7553-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 May 2001, Paul Mackerras wrote:
> 
> The patch below adds a page * argument to copy_user_page and
> clear_user_page.

If you add the page argument, why leave the old arguments lingering there
at all? They only create confusion, and add no information. 

		Linus

