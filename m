Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161271AbWHJOg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161271AbWHJOg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161259AbWHJOg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:36:58 -0400
Received: from mail.visionpro.com ([63.91.95.13]:56791 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S1161271AbWHJOg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:36:57 -0400
User-Agent: Microsoft-Entourage/11.2.4.060510
Date: Thu, 10 Aug 2006 07:36:56 -0700
Subject: Re: Upgrading kernel across multiple machines
From: Brian McGrew <brian@visionpro.com>
To: David Lloyd <dmlloyd@flurg.com>
CC: Sam Ravnborg <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Message-ID: <C1009298.8D00%brian@visionpro.com>
Thread-Topic: Upgrading kernel across multiple machines
Thread-Index: Aca8im3IrEh5bih9Edu5LgAKlbl8Ig==
In-Reply-To: <1155215638.24896.3.camel@ultros>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We got the system working, well, two of the three are working now.

Yesterday I tarred over /lib/modules/2.6.16.16 and /boot/*2.6.16.16*.  This
morning I did a sum on the *2.6.16.16* files in /boot and they did not match
the originals (!?! go figure !?!) so I copied them over so they match and
the machine came right up.

Now we'll see if I can duplicate this on machine #3.

THANKS FOR ALL THE HELP!

:b!


On 8/10/06 6:13 AM, "David Lloyd" <dmlloyd@flurg.com> wrote:

> On Wed, 2006-08-09 at 17:18 -0700, Brian D. McGrew wrote:
>> I tried copying over the initrd as well as making a new one!
> 
> Ok.  The only reason I mention it is that in many cases, necessary boot
> modules are stored in /lib on the initrd image.  Failure to load such a
> module would show up early in the boot sequence, before "real" init
> started up.
> 
> - DML
> 


:b!

-- 
Brian McGrew    { brian@visionpro.com || brian@doubledimenison.com }

> Is he allowed a plea of insanity for a parking ticket?

