Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbTGLSMx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 14:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268243AbTGLSMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 14:12:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:38361 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268231AbTGLSMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 14:12:52 -0400
Date: Sat, 12 Jul 2003 11:27:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: jamie@shareable.org, davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect'
Message-Id: <20030712112722.55f80b60.akpm@osdl.org>
In-Reply-To: <3F103018.6020008@pobox.com>
References: <20030711140219.GB16433@suse.de>
	<20030712152406.GA9521@mail.jlokier.co.uk>
	<3F103018.6020008@pobox.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> One problem is O_DIRECT should return an error on open(2) or fcntl(2), 
>  not write(2).

That is the 2.5 behaviour.
