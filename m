Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262183AbSJHL6l>; Tue, 8 Oct 2002 07:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262199AbSJHL6k>; Tue, 8 Oct 2002 07:58:40 -0400
Received: from 200-184-71-82.chies.com.br ([200.184.71.82]:61519 "EHLO
	elipse.com.br") by vger.kernel.org with ESMTP id <S262183AbSJHL6j>;
	Tue, 8 Oct 2002 07:58:39 -0400
Message-ID: <019401c26ec2$d46e62b0$1c00a8c0@elipse.com.br>
Reply-To: "Felipe W Damasio" <felipewd@elipse.com.br>
From: "Felipe W Damasio" <felipewd@elipse.com.br>
To: "Stig Brautaset" <stig@brautaset.org>, <linux-kernel@vger.kernel.org>,
       <jgarzik@mandrakesoft.com>
References: <20021007220752.GA471@arwen.brautaset.org>
Subject: Re: [patch] 2.5.41: mii breakage in xircom_tulip_cb
Date: Tue, 8 Oct 2002 09:04:18 -0300
Organization: Elipse Software
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-OriginalArrivalTime: 08 Oct 2002 12:04:16.0593 (UTC) FILETIME=[D3345C10:01C26EC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Stig Brautaset" <stig@brautaset.org>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, October 07, 2002 7:07 PM
Subject: [patch] 2.5.41: mii breakage in xircom_tulip_cb


> In 2.5.41 (and .40, at least) the mii-capabilities is not there, I have
> not tested earlier development kernels. The changes between the driver
> in 2.4.19 and 2.5.41 are miniscule, so I was able to make mii work
> again (this is my first attempt at kernel hacking; don't laugh :). It's
> most definately _not_ the correct fix, it is just a revert from 2.4.19
> that makes mii work for me again in 2.5.

   Isn't this (or shouldn't this) be supported by the 2.4 version of the
"generic_mii_ioctl"? Jeff?

   Since this is a rather new function (in since 2.5.40) the fix is valid,
though the net drivers should use this function (I'll look into this).

Felipe

