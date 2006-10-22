Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422825AbWJVBwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422825AbWJVBwv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 21:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422910AbWJVBwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 21:52:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42134 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422825AbWJVBwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 21:52:50 -0400
Subject: Re: PAE broken on Thinkpad
From: Arjan van de Ven <arjan@infradead.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1161472697.5528.6.camel@localhost.localdomain>
References: <1161472697.5528.6.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 22 Oct 2006 03:52:44 +0200
Message-Id: <1161481965.3128.129.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-21 at 16:18 -0700, john stultz wrote:
> Yea. So I know I probably shouldn't run a PAE kernel on my 1Gig laptop,
> but in trying to do so I found it won't boot.


which CPU do you have? Not all laptop processors support PAE at all...
(for example the pentiumM generations before NX was added)

check /proc/cpuinfo the flags line to see if "pae" is there


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

