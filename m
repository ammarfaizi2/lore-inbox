Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbSL1UoV>; Sat, 28 Dec 2002 15:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbSL1UoU>; Sat, 28 Dec 2002 15:44:20 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:55820 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265633AbSL1UoU>; Sat, 28 Dec 2002 15:44:20 -0500
Date: Sat, 28 Dec 2002 13:50:51 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Andrew Morton <akpm@digeo.com>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Tomas Szepe <szepe@pinerecords.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Samuel Flory <sflory@rackable.com>, Janet Morgan <janetmor@us.ibm.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <770128112.1041108651@aslan.scsiguy.com>
In-Reply-To: <3E0E071F.F6819548@digeo.com>
References: <200212281500.gBSF0pc01929@localhost.localdomain>
 <712898112.1041103010@aslan.scsiguy.com> <3E0E071F.F6819548@digeo.com>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Justin T. Gibbs" wrote:
>> 
>> > So far, the only bug report I have is from Andrew Morton proving that
>> > it still  doesn't get it's bounce buffers right.
>> 
>> That hasn't applied since 6.2.10 or so.  2.5.X is still using 6.2.4.
>> 
> 
> 2.5.53 is using 6.2.24, and it is bounce buffering highmem I/O.  6.2.4
> was OK in this regard.

Hmm.  The only previous bug report I had in this area was related to a
missing cast.  That was fixed, but I guess it wasn't enough to solve
the problem.

--
Justin

