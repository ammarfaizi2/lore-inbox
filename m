Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbRGURgF>; Sat, 21 Jul 2001 13:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267773AbRGURfz>; Sat, 21 Jul 2001 13:35:55 -0400
Received: from zero.tech9.net ([209.61.188.187]:64012 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S267771AbRGURfs>;
	Sat, 21 Jul 2001 13:35:48 -0400
Subject: Re: [PATCH] init/main.c
From: Robert Love <rml@tech9.net>
To: Stefan Becker <stefan@oph.rwth-aachen.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0107211840250.27803-100000@die-macht>
In-Reply-To: <Pine.LNX.4.21.0107211840250.27803-100000@die-macht>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.11 (Beta Release)
Date: 21 Jul 2001 13:36:20 -0400
Message-Id: <995736983.2509.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 21 Jul 2001 18:51:07 +0200, Stefan Becker wrote:
>  static int __init profile_setup(char *str)
>  {
> -    int par;
> -    if (get_option(&str,&par)) prof_shift = par;
> +	int par;
> +	if (get_option(&str,&par))
> +		prof_shift = par;
>  	return 1;
>  }

I wrote a similar patch awhile back and submitted it, to no avail.  So,
this is good -- but 2.4.7 already has this fix merged.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

