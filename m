Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVCOFOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVCOFOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVCOFOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:14:12 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:25005 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262261AbVCOFKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:10:30 -0500
Message-ID: <42366E44.1070409@candelatech.com>
Date: Mon, 14 Mar 2005 21:10:28 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Donald Duckie <schipperke2000@yahoo.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MAC address instead of IP
References: <20050315050204.37107.qmail@web53608.mail.yahoo.com>
In-Reply-To: <20050315050204.37107.qmail@web53608.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Duckie wrote:
> Hi!
> 
> I am looking for some sample codes which uses MAC
> address instead of TCP-IP for data transmission. Any
> suggestions are highly appreciated.

Check out the 'man 7 socket' man page and read up on
raw packet sockets.  You can format a packet down to
the ethernet header and send it directly to the
interface transmit queue...

And all this safely from user-space.

Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

