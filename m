Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273255AbRJUUmJ>; Sun, 21 Oct 2001 16:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275675AbRJUUl7>; Sun, 21 Oct 2001 16:41:59 -0400
Received: from dorf.wh.uni-dortmund.de ([129.217.255.136]:21264 "HELO
	mail.dorf.wh.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S273255AbRJUUlw>; Sun, 21 Oct 2001 16:41:52 -0400
Date: Sun, 21 Oct 2001 22:42:21 +0200
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: connect() to localhost non-blocking.
Message-ID: <20011021224221.A8560@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo all,

I wrote a little test program to do some poll() benchmarks.
I changed the host address to localhost and observed that
connect() always returns EINPROGRESS when used with non-blocking
sockets.

>From the man page:

EINPROGRESS
 The socket is non-blocking and the connection cannot be completed
 immediately. It is possible to select(2) or poll(2) for completion by
 selecting the socket for writing.

So my question is:

What is meant by 'cannot be completed immediately' ?
I thought that connections to localhost would complete
without any delay when the application listens ?

thanks for your answers,
Patrick
