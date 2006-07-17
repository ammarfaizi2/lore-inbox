Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWGQObt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWGQObt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWGQObt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:31:49 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24438 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750800AbWGQObs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:31:48 -0400
Date: Mon, 17 Jul 2006 08:28:03 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: kernel panic at load average of 24 is it acceptable ?
In-reply-to: <fa.pLqL2zHzVigenRd4nxSUVosmfvk@ifi.uio.no>
To: Vikas Kedia <kedia.vikas@gmail.com>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, linux-kernel@vger.kernel.org
Message-id: <44BB9E73.50704@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.GOIim+nD/em++2ZW3u6yf9zZzH8@ifi.uio.no>
 <fa.pLqL2zHzVigenRd4nxSUVosmfvk@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vikas Kedia wrote:
> Here is the output of mcelog:
> root@srv1:~# less /var/log/mcelog
> MCE 0
> CPU 0 0 data cache TSC 6988ae18046
> ADDR f87f5ec0
>  Data cache ECC error (syndrome ce)
>       bit46 = corrected ecc error
>  bus error 'local node origin, request didn't time out
>      data read mem transaction
>      memory access, level generic'
> STATUS 9467400000000833 MCGSTATUS 0
> MCE 0
> CPU 0 0 data cache TSC 723b38a3633
> ADDR 3d9fc0
>  Data cache ECC error (syndrome ce)
>       bit46 = corrected ecc error
>       bit62 = error overflow (multiple errors)
>  bus error 'local node origin, request didn't time out
>      data read mem transaction
>      memory access, level generic'
> STATUS d467400000000833 MCGSTATUS 0
> 
> Since it shows ECC error is the hypothesis correct that its the RAM
> problem and replacing it should solve the problem.

That looks like a data cache ECC error, which would point to a CPU 
problem in that case..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

