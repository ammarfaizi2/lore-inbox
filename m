Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRDPLbc>; Mon, 16 Apr 2001 07:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbRDPLbW>; Mon, 16 Apr 2001 07:31:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60680 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130820AbRDPLbL>; Mon, 16 Apr 2001 07:31:11 -0400
Subject: Re: 2.4 raw devices don't do 64bit offset?
To: k.lichtenwalder@computer.org
Date: Mon, 16 Apr 2001 12:33:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3ADAB2B5.50510595@computer.org> from "k.lichtenwalder@computer.org" at Apr 16, 2001 10:52:05 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14p7Fo-0008VK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sorry if this was already discussed, but I couldn't find it in the
> archives. I'm trying to use xine (the linux dvd player) on
> linux-2.4.3-ac3 and can't watch the whole dvd. The reason is that as
> soon as the llseek sets a value in the offset_high field for sys_llseek,
> I get a EINVAL back from the seek. Is this intentional? Or simply still
> (only) a missing feature?

Did you open the file with open64() ?

Alan

