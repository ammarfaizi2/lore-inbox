Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVA0CtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVA0CtA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVAZXS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:18:29 -0500
Received: from farad.aurel32.net ([82.232.2.251]:63459 "EHLO farad.aurel32.net")
	by vger.kernel.org with ESMTP id S262346AbVAZRwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:52:30 -0500
Message-ID: <41F7D95C.8080906@aurel32.net>
Date: Wed, 26 Jan 2005 18:54:36 +0100
From: =?ISO-8859-1?Q?Aur=E9lien_Jarno?= <aurelien@aurel32.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2] I2C: lm80 driver improvement (From Aurelien)
 - Resubmit
References: <200501260249.23583.shawn.starr@rogers.com> <200501260257.35605.shawn.starr@rogers.com> <20050126164212.GA3366@kroah.com>
In-Reply-To: <20050126164212.GA3366@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Jan 26, 2005 at 02:57:35AM -0500, Shawn Starr wrote:
> 
>> static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)
>> {
>>-	if (rpm == 0)
>>+	if (rpm <= 0)
> 
> 
> As was pointed out, this doesn't make any sense.
> 
> Care to redo the patch?
Please note that the problem is not present in the lm78 patch as the 
argument is of type int.

Aurelien

-- 
   .''`.  Aurelien Jarno               GPG: 1024D/F1BCDB73
  : :' :  Debian GNU/Linux developer | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
