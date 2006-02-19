Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWBSUQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWBSUQu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 15:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWBSUQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 15:16:50 -0500
Received: from quechua.inka.de ([193.197.184.2]:31106 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1750992AbWBSUQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 15:16:50 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <43F8C464.3000509@cfl.rr.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FAuzA-0003OM-00@calista.inka.de>
Date: Sun, 19 Feb 2006 21:16:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> wrote:
> No, I wasn't arguing that it should be okay to unplug a usb drive while 
> the system is suspended, I was saying that it is better for the kernel 
> to assume you did not when it can't really tell, since you aren't 
> supposed to do that anyhow.

I wonder if this problem can be solved with a generic multi-path layer.
Every time a new Device shows up, it is tested for known volumnes and
re-attached. That way the USB layer can still generate new devices, and the
filesystem layer will not lose the connection to the devices. 

(with the addtional benefit that it also works cleaner for real multipath
server environments)

Gruss
Bernd
