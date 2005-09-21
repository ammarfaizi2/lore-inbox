Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVIURAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVIURAU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVIURAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:00:19 -0400
Received: from birao.terra.com.br ([200.176.10.197]:26268 "EHLO
	birao.terra.com.br") by vger.kernel.org with ESMTP id S1751200AbVIURAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:00:18 -0400
X-Terra-Karma: -2%
X-Terra-Hash: 4c90acccf3bc464230c979567a0f2060
Message-ID: <433191A2.9030702@terra.com.br>
Date: Wed, 21 Sep 2005 14:00:18 -0300
From: Piter Punk <piterpk@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050905
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, xorg@lists.freedesktop.org
Subject: kernel 2.6.13, USB keyboard and X.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	i am using 2.6.13 in some machines. One of them has a USB keyboard.
My first problem: the keyboard simply doesn't works. I put "usb-handoff" in
prompt and all goes OK.

	But, when i start X i got a second problem, is impossible to type
only one letter, one touch in a key makes a lot of letters, like that:

	lllllliiiiiiinnnnnnnnuuuuxxxxx

	instead

	linux

	The problem don't happens in kernel 2.4.31 (2.4.31 recognizes
the keyboard without usb-handoff, and works great in X).

	Using 2.6.13, i try to configure X and change the "Autorepeat"
option. The default is to wait 500ms before start to repeat. I think
something is wrong and configure to wait 5000ms (5s) before start to
repeat the letters. In X nothing happens, i continue to type:
llllllliiiiiinnnnnnuuuuuuxxxxx

	But, when i stop the X, the console keyboard got really
slow and start to repeat one letter only after i press the key by
five seconds. Following my X configuration.

	I don't know if the bug is in kernel 2.6.13 or in X, because
that i am sending the report to both lists. In kernel 2.4.31 the X
works OK and, in 2.6.13 the console works OK, problem only in X.

	If you want more information, let me know.

								Piter PUNK
