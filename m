Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbTJ0NLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 08:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTJ0NLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 08:11:15 -0500
Received: from savages.net ([12.154.202.18]:14497 "EHLO savages.net")
	by vger.kernel.org with ESMTP id S261696AbTJ0NLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 08:11:13 -0500
Message-ID: <3F9D196C.9080301@savages.net>
Date: Mon, 27 Oct 2003 05:11:08 -0800
From: Shaun Savage <savages@savages.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6t9 SATA slower than 2.4.20
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just compiled and installed kernel 2.6t9 on my RH9 / Asus A7N8X 
Deluxe.  I find the disk access is slower using the 2.6 kernel than the 
2.4.20 kernel.

To get it to work for 2.4.20 kernel I have to use
# hdparm -d1 -X88 /dev/hde
then the buffered disk read goes from 1.5M to 55M

On the 2.6 kernel the buffered disk read is only 16M

What do I have to do to increase the disk speed for kernel 2.6t9?

Shaun Savage

