Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbTFEVyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbTFEVyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:54:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52998 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264916AbTFEVyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 17:54:10 -0400
Date: Thu, 5 Jun 2003 15:07:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER][PATCH] awe_wave.c user pointer dereference
In-Reply-To: <6CB1C41B-979D-11D7-8338-000A95A0560C@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0306051505480.1754-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Jun 2003, Hollis Blanchard wrote:
>
> Two ioctl functions in sound/oss/awe_wave.c were directly dereferencing 
> a user-supplied pointer in a few places. Please apply.

When you do patches like this, can you please add the "__user" annotations 
while you're at it? Also, if your mailer doesn't rape whitespace, I 
seriously prefer patches in-line in the email, so that I don't have to 
edit the email and can reply to it directly?

		Linus


