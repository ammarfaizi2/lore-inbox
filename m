Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWC2OtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWC2OtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 09:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWC2OtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 09:49:16 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:24236 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S1750700AbWC2OtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 09:49:16 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200603291449.k2TEn7av001867@clem.clem-digital.net>
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
To: akpm@osdl.org (Andrew Morton)
Date: Wed, 29 Mar 2006 09:49:07 -0500 (EST)
Cc: clem@clem.clem-digital.net (Pete Clements),
       klassert@mathematik.tu-chemnitz.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060328224904.4949daaf.akpm@osdl.org>
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton
  > > Quoting Steffen Klassert
  > >   > >   Had several of these with git11
  > >   > >   NETDEV WATCHDOG: eth0: transmit timed out
  > >   > 
  > >   > Is this for sure that these messages occured first time with git11?
  > >   > There were no changes in the 3c59x driver between git10 and git11.
  > >   > 
  > > Tried 2.6.15 and could not get a timed out condition.  Looks like
  > > that defect is between 15 and 16 in my case.  
  > > 
  > > Be glad to do any testing that I can.
  > > 
  > 
  > Please try adding the 3c59x module parameter `global_enable_wol=0', see if
  > that helps.
  > 
Driver is compiled in, not module.

-- 
Pete Clements 
