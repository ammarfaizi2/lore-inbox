Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbTEFOHf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbTEFOGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:06:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:58764 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263729AbTEFOFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:05:39 -0400
Subject: Re: Linux 2.5.69
From: "David S. Miller" <davem@redhat.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, acme@conectiva.com.br
In-Reply-To: <20030506133938.GA11062@k3.hellgate.ch>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
	 <20030506133938.GA11062@k3.hellgate.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052230132.983.48.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 07:08:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 06:39, Roger Luethi wrote:
> I'm seeing "kernel BUG at include/linux/module.h:284!" with 2.5.69.
> 
> I first suspected the early summer in Europe made my hardware flaky, but I
> can't reproduce with 2.5.68.

Arnaldo, it's the socket module stuff.  He's using AF_UNIX
as a module.

-- 
David S. Miller <davem@redhat.com>
