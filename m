Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263944AbRFHJb6>; Fri, 8 Jun 2001 05:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263945AbRFHJbs>; Fri, 8 Jun 2001 05:31:48 -0400
Received: from oxmail1.ox.ac.uk ([129.67.1.1]:40882 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S263944AbRFHJbg>;
	Fri, 8 Jun 2001 05:31:36 -0400
Date: Fri, 8 Jun 2001 10:31:35 +0100
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: BUG: race-cond with partition-check
Message-ID: <20010608103134.B15791@sable.ox.ac.uk>
In-Reply-To: <UTC200106080902.LAA228227.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <UTC200106080902.LAA228227.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Jun 08, 2001 at 11:02:11AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl writes:
> --- partitions/check.c~	Thu May 31 22:26:56 2001
> +++ partitions/check.c	Fri Jun  8 10:44:02 2001
> @@ -418,11 +418,10 @@
>  		blk_size[dev->major] = NULL;
>  
>  	dev->part[first_minor].nr_sects = size;
> -	/* No Such Agen^Wdevice or no minors to use for partitions */
> +	/* No such device or no minors to use for partitions */


Any reason why you're silently removing a good old anti-NSA joke?
Conspiracy theorists may have fun with that... :-)

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
