Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291158AbSAaRNE>; Thu, 31 Jan 2002 12:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291159AbSAaRMy>; Thu, 31 Jan 2002 12:12:54 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:1731 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S291158AbSAaRMo>;
	Thu, 31 Jan 2002 12:12:44 -0500
Date: Thu, 31 Jan 2002 18:12:41 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.3/drivers/net/wan/dscc4.c does not compile
Message-ID: <20020131181241.A3524@fafner.intra.cogenit.fr>
In-Reply-To: <200201311304.FAA00344@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201311304.FAA00344@adam.yggdrasil.com>; from adam@yggdrasil.com on Thu, Jan 31, 2002 at 05:04:44AM -0800
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Adam J. Richter <adam@yggdrasil.com> :
> 
> 	linux-2.4.3/drivers/net/wan/dscc4.c does not compile because
            `-> 5
> it referes to the undefined data structure "sync_serial_settings".
> The changes that cause these problems were newly added in 2.4.3.

It's known and will be automagically fixed as soon as the new HDLC code 
goes in (see message of Krzysztof Halasa on l-k the 2002/01/07).

There's (short) documentation at <URL:http://www.cogenit.fr/dscc4/> for the
brave who wants to play with it. An other patch has been sent to allow the 
driver to handle syncppp operation.

Bug the official HDLC maintainer if you want him to push his work. :o)

PS: I read l-k

-- 
Ueimor
