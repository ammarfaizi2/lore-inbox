Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSIBTUx>; Mon, 2 Sep 2002 15:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318389AbSIBTUx>; Mon, 2 Sep 2002 15:20:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51986 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315923AbSIBTUw>;
	Mon, 2 Sep 2002 15:20:52 -0400
Message-ID: <3D73BB19.6000302@mandrakesoft.com>
Date: Mon, 02 Sep 2002 15:25:13 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>, rth@twiddle.net
Subject: required C optimizations?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to get an idea of the minimum compiler requirements necessary 
to build a Linux kernel, excluding parsing requirements.  For example, 
IIRC, some portions of the code depend on 'static inline' working and 
decent constant propagation/folding.

Are you guys aware of a list of such examples, either in your own head 
or written down somewhere?

If you're wondering what this is about, I'm playing around with "tinycc" 
(http://www.tinycc.org/) ...  it's nowhere near building a kernel, being 
basically a C parser that emits binary code, but I wanted to get an idea 
of the obstacles.

	Jeff


