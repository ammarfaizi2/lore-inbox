Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTDRQKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTDRQKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:10:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21777 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263172AbTDRQHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:07:51 -0400
Date: Fri, 18 Apr 2003 09:20:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Rusty Trivial Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] kstrdup
In-Reply-To: <3E9FB2E9.9040308@pobox.com>
Message-ID: <Pine.LNX.4.44.0304180919380.2950-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Apr 2003, Jeff Garzik wrote:
> 
> You should save the strlen result to a temp var, and then s/strcpy/memcpy/

No, you should just not do this. I don't see the point.

		Linus

