Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129137AbRCEJuW>; Mon, 5 Mar 2001 04:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbRCEJuM>; Mon, 5 Mar 2001 04:50:12 -0500
Received: from coldpc.ab.edu.ro ([193.231.35.200]:4102 "EHLO coldpc.ab.edu.ro")
	by vger.kernel.org with ESMTP id <S129134AbRCEJuB>;
	Mon, 5 Mar 2001 04:50:01 -0500
Date: Mon, 5 Mar 2001 12:49:48 +0200 (EET)
From: Bogdan HARJOC <bodi@coldpc.ab.edu.ro>
To: <linux-kernel@vger.kernel.org>
Subject: How do I use syscalls in a module ?
Message-ID: <Pine.LNX.4.30.0103051241060.14231-100000@cdp.cugir.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	HI. I'm not sure I'm supposed to ask newbie questions here, if so,
I'm sorry. But here goes:

	I'm trying to do a driver for a kind of modem that doesn't use
serial ports, but parralel. So I thought it would be enough to simulate a
ttyS* device. But I need to read from a file the parameters for the modem.
I tried using asm/unistd.h, but when I call open(), I get "Bad adress" as
an error. What I would like to know is can syscalls (eg open()/close()/
lseek()/...) be used in a module, and if so, how ?

Thanx for reading.

Bogdan.


