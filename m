Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291192AbSBVBzC>; Thu, 21 Feb 2002 20:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291193AbSBVByw>; Thu, 21 Feb 2002 20:54:52 -0500
Received: from courage.cs.stevens-tech.edu ([155.246.89.70]:26568 "HELO
	courage.cs.stevens-tech.edu") by vger.kernel.org with SMTP
	id <S291192AbSBVByn>; Thu, 21 Feb 2002 20:54:43 -0500
Date: Thu, 21 Feb 2002 20:54:41 -0500 (EST)
From: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>
To: <linux-kernel@vger.kernel.org>
Subject: How to implement listen and accept routines
Message-ID: <Pine.NEB.4.33.0202212054040.7235-100000@courage.cs.stevens-tech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to make my protocol connection-oriented. I am really stuck with
listen and accept routines :-(. As examples, I took:
int tcp_listen_start(struct sock *sk);
struct sock *tcp_accept(struct sock *sk, int flags, int *err);

Could anybody briefly explain me how should I implement them? I know the
purpose of those functions in the userland.
Mainly I have 2 questions:
1. What else besides changing sk->state to TCP_LISTEN should my
"listen_start" do?
2. How do I get a pending "socket" in my "accept" function. Should
sock_alloc a new one or copy it from some queue?

Thanks for any help!
-marek

