Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280163AbRJaLek>; Wed, 31 Oct 2001 06:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280162AbRJaLeb>; Wed, 31 Oct 2001 06:34:31 -0500
Received: from [194.90.137.3] ([194.90.137.3]:45830 "EHLO MAILGW")
	by vger.kernel.org with ESMTP id <S280163AbRJaLeR>;
	Wed, 31 Oct 2001 06:34:17 -0500
Date: Wed, 31 Oct 2001 13:34:38 +0200
From: Michael Rozhavsky <mrozhavsky@opticalaccess.com>
To: Kirill Ratkin <kratkin@egartech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call kernel function from module
Message-ID: <20011031133438.O24143@opticalaccess.com>
In-Reply-To: <01103112311302.00794@nemo> <3BDFD866.E6E997CC@egartech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BDFD866.E6E997CC@egartech.com>; from kratkin@egartech.com on Wed, Oct 31, 2001 at 01:54:30PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
> 
> Hi! Could somebody help me? I added several functions (not sys calls) to
> kernel as hardcoded part. Then I write modules which will be call these
> functions. But when I load module insmod says me 'can't resolve symbol
> my_func_name'.
> I exported all my functions in netsyms.c file. Do you know how I can see
> my function?

use EXPORT_SYMBOL macro from include/module.h

> 
> Regards,
> Niktar.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Best regards.

--
   Michael Rozhavsky			Tel:    +972-4-9936248
   mrozhavsky@opticalaccess.com		Fax:    +972-4-9890564
   Optical Access  
   Senior Software Engineer		www.opticalaccess.com
