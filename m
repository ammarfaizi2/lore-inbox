Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTIJLRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 07:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbTIJLRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 07:17:19 -0400
Received: from dyn-ctb-203-221-72-196.webone.com.au ([203.221.72.196]:39430
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262482AbTIJLRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 07:17:16 -0400
Message-ID: <3F5F0820.3090003@cyberone.com.au>
Date: Wed, 10 Sep 2003 21:16:48 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Luca Veraldi <luca.veraldi@katamail.com>
CC: Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <20030910095255.GA21313@mail.jlokier.co.uk> <20030910120729.C14352@devserv.devel.redhat.com> <20030910103752.GC21313@mail.jlokier.co.uk> <20030910124151.C9878@devserv.devel.redhat.com> <02bc01c37789$ebfa9a40$5aaf7450@wssupremo>
In-Reply-To: <02bc01c37789$ebfa9a40$5aaf7450@wssupremo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Luca Veraldi wrote:

>>Memory is sort of starting to be like disk IO in this regard.
>>
>
>Good. So the less you copy memory all around, the better you permorm.
>

Hi Luca,
There was a zero-copy pipe implementation floating around a while ago
I think. Did you have a look at that? IIRC it had advantages and
disadvantages over regular pipes in performance.

Nick


