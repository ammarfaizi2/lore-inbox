Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbRBPLDR>; Fri, 16 Feb 2001 06:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129322AbRBPLDH>; Fri, 16 Feb 2001 06:03:07 -0500
Received: from t3o61p60.telia.com ([195.67.228.180]:11559 "EHLO k-7.stesmi.com")
	by vger.kernel.org with ESMTP id <S129216AbRBPLDA>;
	Fri, 16 Feb 2001 06:03:00 -0500
Message-ID: <3A8D0991.6278A196@hanse.com>
Date: Fri, 16 Feb 2001 12:05:53 +0100
From: Stefan Smietanowski <stefan@hanse.com>
Organization: Hanse Communication
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Srinivas Surabhi <srinivas.surabhi@wipro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: driver compilations errors
In-Reply-To: <77452AAAFC5.AAA234C@vindhya.mail.wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> iam getting compilation errors  for driver code.
> 
> struct file_operations my_ops ={NULL,my_read,my_write,NULL,NULL,NULL
>                                 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
>                            NULL };                                   ^^^^
                            ^^
> 
> ERROR -> my_ops has intializer but incomplete type

Well, for one there's no "," between the last "NULL"s...

// Stefan
