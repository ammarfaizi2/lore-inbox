Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267834AbTBKNFk>; Tue, 11 Feb 2003 08:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267846AbTBKNFk>; Tue, 11 Feb 2003 08:05:40 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:61056 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267834AbTBKNFj>;
	Tue, 11 Feb 2003 08:05:39 -0500
Date: Tue, 11 Feb 2003 13:11:19 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Heiko Ronsdorf <sk048ro@crimson.ihg.uni-duisburg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][DRIVER][RFC] CPU5 watchdog driver for 2.5
Message-ID: <20030211131119.GA13643@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Heiko Ronsdorf <sk048ro@mail.ihg.uni-duisburg.de>,
	linux-kernel@vger.kernel.org
References: <20030210201732.GA25722@mail.ihg.uni-duisburg.de> <1044916408.4724.11.camel@vmhack> <20030211122620.GA10604@mail.ihg.uni-duisburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030211122620.GA10604@mail.ihg.uni-duisburg.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 01:26:20PM +0100, Heiko Ronsdorf wrote:
 > > * I'm pretty sure that in general adding new code to /proc (that has
 > > nothing to do with processes) is frowned on.
 > 
 > I don't know how to track the watchdog. Suggestions are welcome.

Last week someone suggested a sysfs interface for the watchdog drivers. 
If this is done, it should be in a generic way that all the watchdogs
automatically benefit from rather than duplicate the same sysfs
code in every watchdog driver.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
