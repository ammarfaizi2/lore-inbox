Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279414AbRJWMwq>; Tue, 23 Oct 2001 08:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279416AbRJWMwh>; Tue, 23 Oct 2001 08:52:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:32386 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S279414AbRJWMwb>; Tue, 23 Oct 2001 08:52:31 -0400
Date: Tue, 23 Oct 2001 08:53:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Behavior of poll() within a module
Message-ID: <Pine.LNX.3.95.1011023085214.9875A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What is the intended behavior of poll within a module when
two or more tasks are sleeping in poll? Specifically, when
wake_up_interruptible is executed from a module, are all
tasks awakened or is only one? If only one, is it the
first task to call poll/select or the last, which is awakened
first? 


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


