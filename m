Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbTA1VgG>; Tue, 28 Jan 2003 16:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTA1VgG>; Tue, 28 Jan 2003 16:36:06 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:37606 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261371AbTA1VgF>;
	Tue, 28 Jan 2003 16:36:05 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15926.63959.657142.995107@napali.hpl.hp.com>
Date: Tue, 28 Jan 2003 13:44:55 -0800
To: Jamie Lokier <jamie@shareable.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: {sys_,/dev/}epoll waiting timeout
In-Reply-To: <20030128213621.GA29036@bjl1.asuk.net>
References: <20030122080322.GB3466@bjl1.asuk.net>
	<Pine.LNX.4.33L2.0301281139570.30636-100000@dragon.pdx.osdl.net>
	<20030128213621.GA29036@bjl1.asuk.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 28 Jan 2003 21:36:21 +0000, Jamie Lokier <jamie@shareable.org> said:

  Jamie> Curiously, IA64's own sys_perfmonctl() returns int.

Definitely a bug.  Thanks for catching this.  I'll let the maintainer know.

	--david
