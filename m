Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbUKNGXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUKNGXS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 01:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbUKNGXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 01:23:18 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:691 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261242AbUKNGXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 01:23:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=sHx5AcNMkALRWSiHuQpJVVPynHlpQ3tV2uDc4zoqYrGKv2J2hFrE2uUIC5k8yH0ZNSY0ITgJxrOwzcgN1sLGqeSPUMLPXA77JmOlsR23rNjexvGagcs9rCxpMfmohVy/Qchs+JFvQ5TdboaCaDz7aD1f0XCwopmYyWi+3E4EY78=
Message-ID: <bd8e30a4041113222350934a3e@mail.gmail.com>
Date: Sat, 13 Nov 2004 22:23:14 -0800
From: "Paul G. Allen" <pgallen@gmail.com>
Reply-To: "Paul G. Allen" <pgallen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Compiling RHEL WS Kernels
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently installed RHEL WS Update 3 (kernel 2.4.21-20) on my laptop.
Out of the box it does not recognize any USB devices, my Synaptics
touchpad, my PCMCIA Wireless (NetGear WAG511G) or the proper
resolution on my LCD. (NOTE: RH 9 worked perfectly OOTB on this same
machine. So far I'm not at all impressed with RHEL WS - any more than
I was with RH 7.0.)

I tried to build a new 2.4.21 kernel based upon a configuration from a
non-RH kernel (2.4.24) that worked on this machine. Not a single
module will compile correctly. I had to remove all modules and compile
them into the kernel. I2C code will not compile at all and it had to
be completely removed. After this I was able to compile a working
kernel, but it boots with errors and the NVIDIA driver will not
compile.

I've submitted a service request with Red Hat, but have not yet
received a response.

What compiler versions are known to work with this kernel?

Is this a known problem with RHEL?

My next step may be D/L the latest 2.6 stable kernel and try compiling
that (but that still leaves the question of which gcc version to use).

TIA,

PGA
