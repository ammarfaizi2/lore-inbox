Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267709AbUJUGHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267709AbUJUGHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270311AbUJUGHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 02:07:14 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:3468 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S270513AbUJUGGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:06:06 -0400
References: <20041020181617.GA29435@elf.ucw.cz> <20041020193741.GA27096@shaka.acc.umu.se>
Message-ID: <cone.1098338726.500663.12209.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Tim Cambrant <cambrant@acc.umu.se>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: power/disk.c: small fixups
Date: Thu, 21 Oct 2004 16:05:26 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Cambrant writes:

> On Wed, Oct 20, 2004 at 08:16:17PM +0200, Pavel Machek wrote:
>> power_down may never ever fail, so it does not really need to return
>> anything. Kill obsolete code and fixup old comments. Please apply,
>> 
> 
> ...
> 
>> @@ -162,7 +163,7 @@
>>   *
>>   *	If we're going through the firmware, then get it over with quickly.
>>   *
>> - *	If not, then call pmdis to do it's thing, then figure out how
>> + *	If not, then call swsusp to do it's thing, then figure out how
>>   *	to power down the system.
>>   */
> 
> I hate to be picky, but changing "it's" to the more correct "its" would
> perhaps be nice to do when you're at it?

"it's" means it belongs to, so therefore "it's" is correct usage here.

Con

