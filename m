Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVFMOGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVFMOGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 10:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVFMOGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 10:06:53 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:21137 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261562AbVFMOGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 10:06:49 -0400
Message-ID: <42AD92F2.7080108@yahoo.com.au>
Date: Tue, 14 Jun 2005 00:06:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ondrej Zary <linux@rainbow-software.org>,
       Grant Coady <grant_lkml@dodo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Odd IDE performance drop 2.4 vs 2.6?
References: <ac0qa19omlt7bsh8mcfsfr2uhshk338f0c@4ax.com>	 <42AD6362.1000109@rainbow-software.org> <1118669975.13260.23.camel@localhost.localdomain>
In-Reply-To: <1118669975.13260.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2005-06-13 at 11:43, Ondrej Zary wrote:
> 
>>I see this problem too with i430TX chipset (the south bridge and thus 
>>IDE controller is the same as in i440LX/EX and BX/ZX).
> 
> 
> Make sure you have pre-empt disabled and the antcipatory I/O scheduler
> disabled. 
> 

I don't think that those could explain it.

Increasing readahead with the `blockdev` command has been known
to fix similar reports.

Send instant messages to your online friends http://au.messenger.yahoo.com 
