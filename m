Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144154AbRAHOy5>; Mon, 8 Jan 2001 09:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144153AbRAHOyr>; Mon, 8 Jan 2001 09:54:47 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:1541 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S143885AbRAHOyb>;
	Mon, 8 Jan 2001 09:54:31 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kdb for modules 
In-Reply-To: Your message of "Mon, 08 Jan 2001 10:57:32 -0000."
             <Pine.GSO.4.21.0101081053210.25031-100000@acms23> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Jan 2001 01:54:24 +1100
Message-ID: <1415.978965664@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001 10:57:32 +0000 (GMT), 
Guennadi Liakhovetski <g.liakhovetski@ragingbull.com> wrote:
>Keith Owens wrote
>> kdb v0.6 is out of date and no longer supported. kdb v1.5 against 
>> 2.2.18 is in ftp://oss.sgi.com/projects/kdb/download/ix86/, it supports 
>> modules correctly. This patch is only there as a courtesy, SGI do not 
>> support kdb on 2.2 kernels, all our debugging work is on 2.4 kernels. 
>> If you want to use kdb on 2.2 kernels, you are pretty much on your own. 
>
>Ok, this is fine, but just one question, please: is    
>kdb-v1.5-2.2.18-pre15.gz going (or at least supposed to) work with 2.2.18
>(final)?

The only obvious difference between 2.2.18-pre15 and 2.2.18 that
affects kdb is a change to the sysctl numbers.  I have put
kdb-v1.5-2.2.18.gz in http://oss.sgi.com/projects/kdb/download/ix86/.
Warning: I have not even compiled this patch, let alone tested it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
