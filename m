Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262081AbSJJSgd>; Thu, 10 Oct 2002 14:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbSJJSgd>; Thu, 10 Oct 2002 14:36:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56846 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262081AbSJJSgb>;
	Thu, 10 Oct 2002 14:36:31 -0400
Message-ID: <3DA5CA07.8020503@pobox.com>
Date: Thu, 10 Oct 2002 14:42:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@elipse.com.br>
CC: Stig Brautaset <stig@brautaset.org>, linux-kernel@vger.kernel.org,
       jgarzik@mandrakesoft.com
Subject: Re: [patch] 2.5.41: mii breakage in xircom_tulip_cb
References: <20021007220752.GA471@arwen.brautaset.org> <019401c26ec2$d46e62b0$1c00a8c0@elipse.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe W Damasio wrote:
> ----- Original Message -----
> From: "Stig Brautaset" <stig@brautaset.org>
> To: <linux-kernel@vger.kernel.org>
> Sent: Monday, October 07, 2002 7:07 PM
> Subject: [patch] 2.5.41: mii breakage in xircom_tulip_cb
> 
> 
> 
>>In 2.5.41 (and .40, at least) the mii-capabilities is not there, I have
>>not tested earlier development kernels. The changes between the driver
>>in 2.4.19 and 2.5.41 are miniscule, so I was able to make mii work
>>again (this is my first attempt at kernel hacking; don't laugh :). It's
>>most definately _not_ the correct fix, it is just a revert from 2.4.19
>>that makes mii work for me again in 2.5.
> 
> 
>    Isn't this (or shouldn't this) be supported by the 2.4 version of the
> "generic_mii_ioctl"? Jeff?

Yes, current 2.4.x and 2.5.x trees both have generic_mii_ioctl...

	Jeff



