Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271119AbTGYLVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 07:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271154AbTGYLVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 07:21:06 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:29432 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S271119AbTGYLVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 07:21:04 -0400
Message-ID: <3F211638.3090807@oracle.com>
Date: Fri, 25 Jul 2003 13:36:24 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030723
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: radeon still broken (was: Linux 2.4.22-pre8)
References: <Pine.LNX.4.55L.0307241721130.7875@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0307241721130.7875@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Hello,
> 
> Here goes -pre8. It contains network driver updates, IEEE1394 update, a
> POSIX compliance fix introduced by the execve() security fixes during
> early -pre, amongst others.
> 
> Detailed changelog below

radeon is still broken. Looks obvious since it was broken for me
  since -pre6, and -pre8 didn't change anything apparently... but
  I decided to give -pre8 a spin anyway.

To my surprise, the framebuffer didn't go wild as it happened in
  earlier occasions - as in here:

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.2/0732.html

However, firing startx resulted in a black screen and a hard hang
  (had to keep the poweroff button for 10" to actually power off).

So I tried booting -pre8 again, and this time the framebuffer went
  wild again. It looks like there is a timing issue perhaps ?

I'm available for testing and debugging this - so far I'm stuck
  with -pre4 which is the latest working.


Thanks in advance for any help/insight.

--alessandro

  "Prima di non essere sincera / Pensa che ti tradisci solo tu"
       (Vasco Rossi, 'Prima di partire per un lungo viaggio')

