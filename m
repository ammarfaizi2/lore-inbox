Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264861AbUD3BjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264861AbUD3BjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 21:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUD3BjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 21:39:09 -0400
Received: from ms-smtp-04-smtplb.ohiordc.rr.com ([65.24.5.138]:14056 "EHLO
	ms-smtp-04-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S264861AbUD3BjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 21:39:06 -0400
From: Rob Couto <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: carloschoenberg@yahoo.com
Subject: Re: well-supported motherboard
Date: Thu, 29 Apr 2004 21:38:22 -0400
User-Agent: KMail/1.6.1
References: <S263174AbUDYRbv/20040425173151Z+1925@vger.kernel.org>
In-Reply-To: <S263174AbUDYRbv/20040425173151Z+1925@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404292138.22352.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 April 2004 01:31 pm, you wrote:
> I am looking for a motherboard that is known to work well with Linux.
> "Known to work well" means:
> 1) working open source drivers exist for all onboard components
> 2) most people are not experiencing random crashes or data corruption,
> or the reason for such is understood and a proper fix exists.
> 3) multiple people are using the board successfully
> 4) no VIA northbridge/southbridge, though other VIA components might
> be OK.  Although there are people successfully using VIA chipsets, I
> do not believe that VIA considers the stability of their products to
> be an important concern.

a friend has nothing wrong with his 845PE-based ABIT BE7. everything works, 
down to the sensors (which i still have to tweak in /etc/sensors.conf for 
accuracy). no 1394, only 4x agp, and 1 ethernet, so not quite your speed. 
also 2GB is the RAM ceiling.

now if the 875P-based IC7-MAX3 is as good, it has most if not all of what 
you're after, I wonder: has anyone tried this board? I'm thinking in that 
direction, dual channel DDR, 1394, etc. and especially the CSA gigabit 
ethernet. I would like to keep it free from butterfly infestation... 

> It seems that no one does proper testing of motherboards with Linux.
> Although I can find reviews that put a variety of boards through a
> handful of tests in Windows, I can't find any reviews that properly
> test Linux.

this BE7 cheerfully runs a 2.0A P4 at 3.1GHz, Vcore at +15%, about 70 deg. 
*celsius* core temp in an air-conditioned room at 100% load for as long as 
you want. GCC stabilizes at 2.8~2.9GHz where you can get away with Vcore at 
+10%. The AGP is quick, in fact, opengl (and lately some direct3d) in wine is 
about as fast as that other OS. never got 3dMark2001 to run in wine, so it's 
hard to say for sure... it only screws up when you get irresponsible with 
gentoo's optimizer settings. a stock slackware is solid, also with a -ck 
patchset.

-- 
Rob Couto [rpc@cafe4111.org]
computer safety tip: use only a non-conducting, static-free hammer.
--
