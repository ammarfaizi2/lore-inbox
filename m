Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289865AbSAPFPQ>; Wed, 16 Jan 2002 00:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289867AbSAPFPH>; Wed, 16 Jan 2002 00:15:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3083 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289865AbSAPFOw>;
	Wed, 16 Jan 2002 00:14:52 -0500
Message-ID: <3C450C4A.8A8382A6@mandrakesoft.com>
Date: Wed, 16 Jan 2002 00:14:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: likely/unlikely
In-Reply-To: <20020116032300.AAA27749@shell.webmaster.com@whenever>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 
>         By the way, has anybody actually benchmarked these macros to see if they
> make any difference. I did a few quick inexact benchmarks on test code and
> found that in most cases there was no difference and in some cases code was
> made worse.

likely/unlikely set the branch prediction values to 99% or 1%
respectively.  If this causes the code generated to perform less
optimally than without, I'm sure the gcc guys would be -very- interested
to hear that...

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
