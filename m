Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272551AbRH3XNO>; Thu, 30 Aug 2001 19:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272549AbRH3XNF>; Thu, 30 Aug 2001 19:13:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:40576 "EHLO
	e34.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272548AbRH3XM6> convert rfc822-to-8bit; Thu, 30 Aug 2001 19:12:58 -0400
Date: Thu, 30 Aug 2001 16:07:08 -0700
From: Jonathan Lahr <lahr@us.ibm.com>
To: Eric Youngdale <eric@andante.org>
Cc: =?iso-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: io_request_lock/queue_lock patch
Message-ID: <20010830160708.G23680@us.ibm.com>
In-Reply-To: <20010830232228.C2120-100000@gerard> <008801c1319d$57f16970$4d0310ac@fairfax.mkssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <008801c1319d$57f16970$4d0310ac@fairfax.mkssoftware.com>; from eric@andante.org on Thu, Aug 30, 2001 at 05:47:19PM -0400
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there an estimate on when the 2.5 i/o subsystem will be released?

Jonathan

Eric Youngdale [eric@andante.org] wrote:
>     I am afraid I would have to agree with Gérard.  We were planning on
> cleaning this mess up in the 2.5 kernel, and my inclination would be to
> leave this alone until then.
> 
> -Eric
> 
> ----- Original Message -----
> From: "Gérard Roudier" <groudier@free.fr>
> To: "Jonathan Lahr" <lahr@us.ibm.com>
> Cc: <linux-kernel@vger.kernel.org>; <linux-scsi@vger.kernel.org>
> Sent: Thursday, August 30, 2001 5:32 PM
> Subject: Re: io_request_lock/queue_lock patch
> 
> 
> >
> > Here are my welcome comments. :)
> >
> > In my opinion, it would well be a miracle if your patch does not introduce
> > new race conditions, at least for drivers that still use the old scsi done
> > method.
> >
> >   Gérard.
