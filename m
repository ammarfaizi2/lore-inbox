Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264204AbRGELGx>; Thu, 5 Jul 2001 07:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264329AbRGELGn>; Thu, 5 Jul 2001 07:06:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42758 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264204AbRGELGh>; Thu, 5 Jul 2001 07:06:37 -0400
Subject: Re: tcp stack tuning and Checkpoint FW1 & Legato Networker
To: kern@wolf.ericsson.net.nz
Date: Thu, 5 Jul 2001 12:06:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0107051331190.2882-100000@wolf.ericsson.net.nz> from "kern@wolf.ericsson.net.nz" at Jul 05, 2001 01:49:33 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15I6y4-0002Lk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want to set the tcp_keepalive timer to 60 seconds and understand
> possible implications for Linux.

The RFC's strictly forbid it being below two hours

> If I set the tcp_keepalive timer to 60 seconds then keepalives will keep
> the connection established for the duration of the backup which could be
> 50 minutes for a large partition.  I can set this under solaris with ndd
> tcp_keepalive_interval 60000 (ms)

And the moment you leave a few boxes tuned like that on the internet you'll
find yourself very unpopular.

Get the checkpoint box reconfigured properly

