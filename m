Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUFKGJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUFKGJM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 02:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbUFKGJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 02:09:12 -0400
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:34283 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261865AbUFKGJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 02:09:09 -0400
From: Stuart Young <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: flush cache range proposal (was Re: ide errors in 7-rc1-mm1 and later)
Date: Fri, 11 Jun 2004 16:10:34 +1000
User-Agent: KMail/1.6.2
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
References: <1085689455.7831.8.camel@localhost> <20040610164135.GA2230@bounceswoosh.org> <40C89F4D.4070500@pobox.com>
In-Reply-To: <40C89F4D.4070500@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406111610.34649.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2004 03:50, Jeff Garzik wrote:

> 2) IDENTIFY DEVICE, Word 207, Command set/feature enabled
>
> bit 15:		shall be cleared to zero
> bit 14:		shall be set to one
> bits 13:1:	reserved
> bits 0:		1 == flush cache (range) enabled
>
> Word 206:
>
> If bit 0 is set to one, the mandatory FLUSH CACHE and FLUSH CACHE EXT
> commands (if implemented) support the RANGE bit, and user-supplied LBA
> and sector count specifying the limits of the cache flush.

Shouldn't that be "Word 207:" up there?

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
