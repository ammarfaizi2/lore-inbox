Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265450AbTF3QwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 12:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbTF3QwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 12:52:12 -0400
Received: from zeus.kernel.org ([204.152.189.113]:16272 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265450AbTF3QwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 12:52:10 -0400
Message-ID: <3F006421.4090408@colorfullife.com>
Date: Mon, 30 Jun 2003 18:24:01 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ray Bryant <raybry@sgi.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@suse.de>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: PROBLEM: Bug in __pollwait() can cause select() and poll() to
 hang in 2.4.22-pre2 -- second try
References: <20030630051515.E9F992C0D5@lists.samba.org>
In-Reply-To: <20030630051515.E9F992C0D5@lists.samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

>2.5 has exactly the same issue: perhaps 2.4 should take this patch,
>and 2.5 should try something better (I'd suggest trying the embedded
>minitable approach).
>
>  
>
I tried it, but Linus didn't like the idea of on-stack minitables. The 
patches are still at
http://www.colorfullife.com/~manfred/Linux-Kernel/poll/

--
    Manfred

