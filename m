Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270701AbTG0Jnn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 05:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270703AbTG0Jnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 05:43:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:58835 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S270701AbTG0Jnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 05:43:42 -0400
Message-ID: <3F23A25A.3050708@freenet.co.uk>
Date: Sun, 27 Jul 2003 10:58:50 +0100
From: D Qi <dqi@freenet.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en,zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: snap support in linux
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fellows,

I am writing a network driver for 2.4.10 kernel on ARM Integrator. It 
works almost properly by now(normal telnet, ftp etc works). Now we are 
tring to do some tests. It seems it refuse to response to the SNAP 
frame. We are pretty sure the hardware received it and passed it to the 
driver, the driver then passed it to the kernel. But the problem is the 
kernel won't reponse to it.

Is this a issue for the network setting of the running Linux box or some 
thing else? Does SNAP frame work by default or is there some thing need 
to be done at the driver level? Please help.

Thanks,

David

