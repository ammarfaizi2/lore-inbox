Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUDXI2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUDXI2r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 04:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUDXI2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 04:28:47 -0400
Received: from fmr02.intel.com ([192.55.52.25]:20447 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262062AbUDXI2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 04:28:45 -0400
Subject: RE: PROBLEM: Second processor not responding in 2.4.21 and later
From: Len Brown <len.brown@intel.com>
To: Marc Rieffel <marc@paracel.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F93AE@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F93AE@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1082795309.22229.8.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Apr 2004 04:28:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-20 at 12:29, Marc Rieffel wrote:
> It looks like things changed dramatically from 2.4.20-pre4 to
> 2.4.20-pre5.  Can you help me figure out which of the changes was
> responsible?
> 
> Thanks.
> 
> Kernel                  Fail    Pass    Fail%
> 
> 2.4.18-27.7.xsmp                0       3314    0.0000
> 2.4.18                  5       4206    0.0012
> 2.4.19                  12      25786   0.0005
> 2.4.20-pre4                     2       586     0.0034
> 2.4.20-pre5                     2       49      0.0392
> 2.4.20-pre6                     12      745     0.0159
> 2.4.20                  55      3128    0.0173
> 2.4.20-20.7smp          483     15427   0.0304
> 2.4.21-4.0.1.ELsmp      155     7278    0.0209

While a difference between 2.4.20-pre4 and -pre5 may be a clue,
it isn't the root cause, because they're both broken.
Looks like only 2.4.18-27.7.xsmp (whatever that is) got 0 failures.

Any chance you can run a test with, say, 2.6.5?
It might also be interesting to know what compiler built each kernel..

cheers,
-Len


