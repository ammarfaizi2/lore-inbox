Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbREOWXi>; Tue, 15 May 2001 18:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbREOWX2>; Tue, 15 May 2001 18:23:28 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:868
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S261645AbREOWXN>; Tue, 15 May 2001 18:23:13 -0400
Message-ID: <3B01AC4E.8020805@fugmann.dhs.org>
Date: Wed, 16 May 2001 00:23:10 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-ac9 i686; en-US; rv:0.9+) Gecko/20010513
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Exporting symbols from a module.
In-Reply-To: <200105152157.f4FLvAw9021664@webber.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
Thanks for your reply.

I'm not sure where to put this in my Makefile.
(tried, but it did not help)
Could you please send an example.

Thanks in advance.
Anders Fugmann

Andreas Dilger wrote:

>>
> I just recently had this problem, and your Makefile is missing:
> 
> export-objs := <file name>.o
> 
> where <file name>.o is the compiled object file from <file name>.c, and
> not the module name (if it is different).
> 
> Cheers, Andreas
> 


