Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTFZSyh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 14:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTFZSyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 14:54:37 -0400
Received: from mailhost3.tudelft.nl ([130.161.180.83]:47827 "EHLO
	mailhost3.tudelft.nl") by vger.kernel.org with ESMTP
	id S262361AbTFZSyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 14:54:35 -0400
Message-ID: <3EFB44BF.1010208@balpol.tudelft.nl>
Date: Thu, 26 Jun 2003 21:08:47 +0200
From: Thijs <thijs@balpol.tudelft.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030612
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: weird postfix mailspool corruption with 2.4.21-ac2+ (was Re:
 Linux 2.4.21-ac3)
References: <2pxg.4uT.27@gated-at.bofh.it> <2r5T.6gb.13@gated-at.bofh.it> <2r5T.6gb.11@gated-at.bofh.it> <2rSk.72B.7@gated-at.bofh.it>
In-Reply-To: <2rSk.72B.7@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott McDermott wrote:
> 
> does changing the unix_dgram_ops `poll' op from `dgram_poll'
> to `datagram_poll' in net/unix/af_unix.c change anything for
> you? I can't test this myself until later this week.  Also I
> don't know what other bug the unix_peer_get() addition is
> supposed to fix, so...

Tried it, but doesn't fix it, unfortunately...
guess it's time for the next suspect ;)

regards,

--Thijs Welman



