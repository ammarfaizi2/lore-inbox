Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSFZOwS>; Wed, 26 Jun 2002 10:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSFZOwR>; Wed, 26 Jun 2002 10:52:17 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:61692 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S316614AbSFZOwR>; Wed, 26 Jun 2002 10:52:17 -0400
Message-ID: <3D19D4BE.45516C90@austin.ibm.com>
Date: Wed, 26 Jun 2002 09:50:38 -0500
From: Bill Hartner <hartner@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Mala Anand <manand@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: efficient copy_to_user and copy_from_user routines in 
 Linux Kernel
References: <OFCB119CD8.D6AE7B3D-ON85256BE2.006AC911@raleigh.ibm.com> <3D18A26A.73E6DD07@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:
> 
> Mala Anand wrote:
> >
> > Here is a 2.5.19 patch that improves the performance of IA32 copy_to_user
> > and copy_from_user routines used by :
...
> 
> One question:  have you tested on other CPU types?  This problem is
> very specific to Intel hardware.  On AMD, the eight-byte alignement
> artifact does not exist at all.  It could be that your patch is not
> desirable on such CPUs?
> 

In Mala's lab, there are a couple of 1.6 Ghz P4 systems that can be used to test on.

There is also a Netbench (P4 and PIII Xeon) and SPECweb99 (PIII Xeon) setup
that can be used for further testing.

There are some older P6 systems available too.  Not sure about AMD yet.

Bill
