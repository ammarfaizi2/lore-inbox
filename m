Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289893AbSAPJR2>; Wed, 16 Jan 2002 04:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290389AbSAPJRM>; Wed, 16 Jan 2002 04:17:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18957 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289893AbSAPJO7>;
	Wed, 16 Jan 2002 04:14:59 -0500
Message-ID: <3C454491.CA18D4AE@mandrakesoft.com>
Date: Wed, 16 Jan 2002 04:14:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Craig Christophel <merlin@transgeek.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: likely/unlikely
In-Reply-To: <20020116032300.AAA27749@shell.webmaster.com@whenever> <3C450C4A.8A8382A6@mandrakesoft.com> <20020116113143.C99F8B581@smtp.transgeek.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Christophel wrote:
> 
> > likely/unlikely set the branch prediction values to 99% or 1%
> 
>         So all of the BUG() routines in the kernel would benifit greatly from this.


It's likely :)  I would put one unlikely() in the definition of BUG_ON,
rather rather touching all the code that calls BUG(), though.

	Jeff



-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
