Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbUAYOiv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 09:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbUAYOiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 09:38:51 -0500
Received: from rat-4.inet.it ([213.92.5.94]:51085 "EHLO rat-4.inet.it")
	by vger.kernel.org with ESMTP id S264361AbUAYOiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 09:38:50 -0500
From: Paolo Ornati <ornati@lycos.it>
To: Jaakko Helminen <haukkari@ihme.org>
Subject: Re: i/o wait eating all of CPU on 2.6.1
Date: Sun, 25 Jan 2004 15:37:50 +0100
User-Agent: KMail/1.5.2
References: <20040125143042.GA20274@ihme.org>
In-Reply-To: <20040125143042.GA20274@ihme.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401251537.50986.ornati@lycos.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 January 2004 15:30, Jaakko Helminen wrote:
> I have two servers, both of which have more than 300 gigabytes of hard
> drive space and those files are made available to the network with samba,
> nfs and http and it worked fine with 2.6.0 but when I upgraded to 2.6.1 I
> noticed that everything was VERY slow, from a machine that is connected
> to the other server with a 100M link, 57kB/s tops. i/o wait eats up all
> of the cpu. On the other hand, Apache (and everything else) works very
> fast when I only send /dev/zero to a client, since that doesn't need disk
> operations.
>
> I don't notice anything suspicious in dmesg but since this happens on two
> machines and has only happened when upgraded to 2.6.1, it's most likely
> because of 2.6.1. I'm downgrading to 2.6.0 (with mremap-patch) today if I
> don't figure out what is wrong. Any ideas?

Is DMA enabled with 2.6.1 on these two machines?

-- 
	Paolo Ornati
	Linux v2.6.2-rc1-mm3

