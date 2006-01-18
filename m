Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWARHAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWARHAs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWARHAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:00:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47493 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030268AbWARHAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:00:46 -0500
Subject: Re: Linux 2.6.16-rc1 -- which gcc version?
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0601180810270.29057@boston.corp.fedex.com>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
	 <20060117183916.399b030f.diegocg@gmail.com>
	 <Pine.LNX.4.64.0601170946050.3240@g5.osdl.org>
	 <Pine.LNX.4.64.0601180810270.29057@boston.corp.fedex.com>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 08:00:40 +0100
Message-Id: <1137567640.3005.64.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 08:22 +0800, Jeff Chua wrote:
> 
> Which gcc version should I use, now that gcc-2.95.3 can't compile
> 2.6.16-rc1 anymore? gcc-3.3 as mentioned in the patch?


alternative is to just use any compiler that came with a distro, and is
at least of 3.2 vintage. (the 3.3 thing is mostly for arm; 3.2 on arm
seemed to not have been a good thing). Distros usually put in fixes to
gcc that are from higher/later versions, eg gcc.gnu.org releases
sometimes have a few bad bugs at release time that will get fixed later,
while the distros put those fixes in immediately.


