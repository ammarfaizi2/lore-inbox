Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316163AbSFESj1>; Wed, 5 Jun 2002 14:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSFESj0>; Wed, 5 Jun 2002 14:39:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15122 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316192AbSFESjY>;
	Wed, 5 Jun 2002 14:39:24 -0400
Message-ID: <3CFE5A50.9010002@mandrakesoft.com>
Date: Wed, 05 Jun 2002 14:37:04 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
In-Reply-To: <3CFD50B9.259366F4@zip.com.au> <1023272806.15438.106.camel@bip> <3CFDEA79.2980BF8D@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think a per-disk laptop mode is reasonable... one might have virtual 
ATA devices like this 128MB flash chip I have (you plug it right into an 
ATA socket, no cables needed.   But I also agree that's a limited set of 
cases, and the additional complexity may not be worth it.

I've also thought in the past of having a "machine_policy" global 
variable, which could indicate to random userspace and kernel code a 
"laptop mode" or "file server mode" or "database server mode" etc.

    Jeff




