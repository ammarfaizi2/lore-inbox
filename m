Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWHIWKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWHIWKB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWHIWKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:10:01 -0400
Received: from mail.visionpro.com ([63.91.95.13]:27786 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S1751397AbWHIWKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:10:00 -0400
User-Agent: Microsoft-Entourage/11.2.4.060510
Date: Wed, 09 Aug 2006 15:10:00 -0700
Subject: Re: Upgrading kernel across multiple machines
From: Brian McGrew <brian@visionpro.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: <linux-kernel@vger.kernel.org>
Message-ID: <C0FFAB48.89A4%brian@visionpro.com>
Thread-Topic: Upgrading kernel across multiple machines
Thread-Index: Aca8AI5LzJm+2CfzEdu24AAKlbl8Ig==
In-Reply-To: <20060809150737.7a0c99ee.rdunlap@xenotime.net>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the most debug I get.  I've taken the rhgb and quiet options out of
my grub.conf file and I still only get about ten lines printed before it
blows up.  There are no files updated on disk that I can find.

:b!


On 8/9/06 3:07 PM, "Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Wed, 09 Aug 2006 14:52:41 -0700 Brian McGrew wrote:
> 
>> Hello,
>> 
>> I'm using a Dell PE1800 and I've built a new 2.6.16.16 kernel on the machine
>> that works fine.  However, if I tar up /lib/modules/2.6.16.16 and /boot and
>> move it onto another Dell PE1800 running the exact same software (FC3/Stock
>> install) the new kernel doesn't boot.
>> 
>> On machine #1 life is good but moving it to machine #2, I get
>> 
>> /lib/ata_piix.ko: -l unknown symbol in module.
>> 
>> What am I missing?  Someone help please, I'm in a major time crunch!
> 
> Hi again,
> Were you able to get any more kernel log messages?
> They will say exactly which symbol(s) is missing.
> 
> Maybe adding "debug" to the kernel command line would produce more
> messages, although many init scripts change that setting (ugh).
> 
> ---
> ~Randy


:b!


-- 
Brian McGrew    { brian@visionpro.com || brian@doubledimenison.com }

> YOU!!!  Off my planet!

