Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130458AbQKNMcU>; Tue, 14 Nov 2000 07:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131032AbQKNMcK>; Tue, 14 Nov 2000 07:32:10 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:10588
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130458AbQKNMcE>; Tue, 14 Nov 2000 07:32:04 -0500
Date: Tue, 14 Nov 2000 13:59:24 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.2.17, not in 2.2.14-5
Message-ID: <20001114135924.A3649@jaquet.dk>
In-Reply-To: <20001113180449.A652@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001113180449.A652@jaquet.dk>; from rasmus@jaquet.dk on Mon, Nov 13, 2000 at 06:04:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get this also with 2.2.17pre10 (which was what I was running before
> encountering this) but not with the stock RH 6.2 kernel (2.2.14-5.0).
> Unless I get other suggestions I'm going to try with the latest 2.2.18pre
> and 2.2.16 tomorrow.
> 

OK, I tried with 2.2.16 and 2.2.18pre21 compiled with egcs-2.91.66
(the kernels reported yesterday were compiled with 2.95.2).

2.2.16 oopsed faithfully (I could not get hold of the oops as several
scrolled by and none made it to the log). 2.2.18pre21 does not oops.
Bzip2 core dumps, but gzip makes it through. So it seems that my
problem has been solved already and proactively :)

Regards,
  Rasmus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
