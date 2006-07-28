Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161158AbWG1TpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbWG1TpR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWG1TpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:45:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38076 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030286AbWG1TpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:45:15 -0400
Subject: Re: A better interface, perhaps: a timed signal flag
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Theodore Tso <tytso@mit.edu>, Neil Horman <nhorman@tuxdriver.com>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <1154105089.19722.23.camel@localhost.localdomain>
References: <44C67E1A.7050105@zytor.com>
	 <20060725204736.GK4608@hmsreliant.homelinux.net>
	 <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain>
	 <70FED39F-E2DF-48C8-B401-97F8813B988E@kernel.crashing.org>
	 <20060725235644.GA5147@localhost.localdomain> <44C6B117.80300@zytor.com>
	 <20060726002043.GA5192@localhost.localdomain>
	 <20060726144536.GA28597@thunk.org>
	 <1154093606.19722.11.camel@localhost.localdomain>
	 <20060728145210.GA3566@thunk.org>
	 <1154104885.13509.142.camel@localhost.localdomain>
	 <1154105089.19722.23.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 21:01:58 +0100
Message-Id: <1154116918.13509.162.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-07-28 am 12:44 -0400, ysgrifennodd Steven Rostedt:
> But for real-time applications, the signal handling has a huge latency.

For real-time you want a thread. Our thread switching is extremely fast
and threads unlike signals can have RT priorities of their own

