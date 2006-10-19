Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945903AbWJSOFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945903AbWJSOFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422992AbWJSOFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:05:44 -0400
Received: from ns.suse.de ([195.135.220.2]:62087 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422981AbWJSOFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:05:44 -0400
From: Andi Kleen <ak@suse.de>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: + i386-time-avoid-pit-smp-lockups.patch added to -mm tree
Date: Thu, 19 Oct 2006 16:05:39 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com, mingo@elte.hu,
       tglx@linutronix.de
References: <200610112126.k9BLQqKG002529@shell0.pdx.osdl.net> <200610191547.09640.ak@suse.de> <1161266225.11264.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
In-Reply-To: <1161266225.11264.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191605.39933.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You just mean the if statement above though? I was talking more about
> the structure above this called "clocksource_pit" which isn't used on
> SMP systems due to this code addition. AFAIK init_pit_clocksource()
> could disappear along with the clocksource structure ..

It will end up as a int f() { return 0; }. Not very much overhead. 

-Andi
