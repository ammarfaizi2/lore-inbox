Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265329AbTLNCCx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 21:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbTLNCCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 21:02:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34705 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265329AbTLNCCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 21:02:52 -0500
Message-ID: <3FDBC4BB.80904@pobox.com>
Date: Sat, 13 Dec 2003 21:02:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcus Blomenkamp <Marcus.Blomenkamp@epost.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: r8169 GigE driver problem, locks up 2.4.23 NFS subsystem
References: <200312131300.05847.Marcus.Blomenkamp@epost.de>
In-Reply-To: <200312131300.05847.Marcus.Blomenkamp@epost.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Blomenkamp wrote:
> Hi all.
> 
> Since ugrading from a realtek-8139 based nic to a realtek-6139 gigabit one i 
> am experiencing strange network problems. Particularly it locks up the NFS 
> subsystem on writing to remote files.

Can you try the vastly updated r8169 driver in the following patch?

http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test11-bk5-netdrvr-exp2.patch.bz2

