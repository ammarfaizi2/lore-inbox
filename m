Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTKHTCF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 14:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTKHTCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 14:02:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:17074 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262030AbTKHTCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 14:02:02 -0500
Date: Sat, 8 Nov 2003 10:59:44 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <ktatgenhorst@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing asm-generic during make config
Message-Id: <20031108105944.31a0c923.rddunlap@osdl.org>
In-Reply-To: <NDBBJHDEALBBOIDJGBNNCEGFCJAA.ktatgenhorst@comcast.net>
References: <NDBBJHDEALBBOIDJGBNNCEGFCJAA.ktatgenhorst@comcast.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Nov 2003 11:07:10 -0500 "Karl" <ktatgenhorst@comcast.net> wrote:

| Hello,
| 
|     I am a list newby and did look for this info, I apologize if my search
| was just not good enough. I have installed 2.6.0 test 9 on 2 machines of
| mine. One is a gateway Pentium II PC and the other is an IBM Netfinity
| server. In both cases when I tried running make config I was given the
| message (I apologize I went on and am paraphrasing) asm-generic/errno.h no
| such file. In both cases I went in to the /usr/include directory and created
| a symlink ln -s /usr/src/linux/include/asm-generic asm-generic and it
| worked. My question is did I miss a README file somewhere which would cover
| this? I think I did all the steps as per instructions on both machines (they
| certainly compiled nicely and run well). I did not include very much about
| the configurations of my machines as I thought they would be unnecessary as
| this is almost certainly a procedural error on my part and not a bug.
| 
|    I appreciate any answers to this and apologize if it is redundant.

That problem doesn't happen for me with a clean untar of test9.tar.bz2.
Maybe you should post all of the messages from 'make config'.

Alternatively, don't use 'make config'.  I can't quite imaging going
thru all of those prompts.  Try 'make defconfig; make menuconfig' instead.

--
~Randy
