Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268319AbTBMXZb>; Thu, 13 Feb 2003 18:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268322AbTBMXZb>; Thu, 13 Feb 2003 18:25:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16653 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268319AbTBMXZa>;
	Thu, 13 Feb 2003 18:25:30 -0500
Message-ID: <3E4C2B9B.8000509@pobox.com>
Date: Thu, 13 Feb 2003 18:34:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, mike_phillips@urscorp.com,
       phillim2@comcast.net
Subject: Re: [BUG] smctr.c changes in latest BK
References: <Pine.LNX.4.44.0302140001160.28838-100000@gfrw1044.bocc.de>
In-Reply-To: <Pine.LNX.4.44.0302140001160.28838-100000@gfrw1044.bocc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Friedrich wrote:
> After taking a second look, i just recognized that both cases (MAC adress
> all-zero or not) are handled exactly the same (by duplicated code), so the
> whole stuff is unnecessary.
> 
> The whole function just reduces to a simple copy loop:


yep, you're right.  applied.

