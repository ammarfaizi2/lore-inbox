Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264888AbSJOSKO>; Tue, 15 Oct 2002 14:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264890AbSJOSKO>; Tue, 15 Oct 2002 14:10:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39185 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264888AbSJOSKN>;
	Tue, 15 Oct 2002 14:10:13 -0400
Message-ID: <3DAC5B47.7020206@pobox.com>
Date: Tue, 15 Oct 2002 14:15:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
CC: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Device-mapper submission 6/7
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Device mapper]
> Provide a traditional ioctl based interface to control device-mapper
> from userland.


If you're adding a new interface, there should be no need to add new 
ioctls and all that they entail.  Just control via a ramfs-based fs...

	Jeff




