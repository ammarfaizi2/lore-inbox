Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263600AbUDUSBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUDUSBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbUDUSBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:01:14 -0400
Received: from sitemail2.everyone.net ([216.200.145.36]:15293 "EHLO
	omta08.mta.everyone.net") by vger.kernel.org with ESMTP
	id S263586AbUDUSBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:01:00 -0400
X-Eon-Sig: AQHOS7NAhrbcAontggIAAAAC,16fcedadfdff23f57169f35b277a2d69
Date: Wed, 21 Apr 2004 14:00:58 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inline_hunter 0.2 and it's results
Message-ID: <20040421180058.GA12468@ohio.localdomain>
References: <200404162230.40530.vda@port.imtp.ilyichevsk.odessa.ua> <20040419214041.GA3749@ohio.localdomain> <200404210901.48882.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404210901.48882.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 09:01:48AM +0300, Denis Vlasenko wrote:
> > Why are there two copy_from_user lines?
[...]
> Because there are files which has 56 byte copy_from_user().
[...]
> Rest of them (~400 files) has 43 byte one.

Hi Denis,

Does this mean copy_from_user is really "wasting" 10K, 16K, or 26K?  If I
understand your email correctly the 10K number is the most accurate..

Great work - thanks!
-Kevin

-- 
 ---------------------------------------------------------------------
 | Kevin O'Connor                  "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net               'IMHO', 'FAQ', 'BTW', etc. !"    |
 ---------------------------------------------------------------------
