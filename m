Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269020AbUJQDNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269020AbUJQDNY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 23:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269022AbUJQDNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 23:13:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47048 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269020AbUJQDNX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 23:13:23 -0400
Message-ID: <4171E346.4@pobox.com>
Date: Sat, 16 Oct 2004 23:13:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de,
       axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com> <20041016171458.4511ad8b.akpm@osdl.org> <4171C20D.1000105@pobox.com> <4171C9CD.4000303@yahoo.com.au> <4171D5F8.8050504@pobox.com> <4171D6A0.4030200@yahoo.com.au> <4171E16A.4020506@pobox.com> <4171E1DB.3050701@yahoo.com.au>
In-Reply-To: <4171E1DB.3050701@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Jeff Garzik wrote:
> 
>> The attached patch does indeed seem to solve the problem.
>>
> 
> OK thanks... and kswapd isn't using lots of CPU while things are
> otherwise idle?


doesn't appear to be chewing CPU, no..

