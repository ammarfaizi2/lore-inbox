Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTJVAKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 20:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTJVAKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 20:10:24 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:15281 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263178AbTJVAKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 20:10:23 -0400
Message-ID: <1066781410.8fc9a83422a85@carlthompson.net>
X-Priority: 3 (Normal)
Date: Tue, 21 Oct 2003 17:10:10 -0700
From: Carl Thompson <cet@carlthompson.net>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: arjanv@redhat.com, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       Dominik Brodowski <linux@brodo.de>, linux-acpi <linux-acpi@intel.com>,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 3/3 Dynamic cpufreq governor and updates toACPIP-state
	driver
References: <7F740D512C7C1046AB53446D3720017304B038@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D3720017304B038@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 192.168.0.174
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Nakajima, Jun" <jun.nakajima@intel.com>:

> ...

> Then you can put the CPU in C-state or lower P-state after (or even
> during) your word processor displays the letter. Even you can type very
> fast, the CPU is almost idle. Having frequent feedbacks simply provide
> more chances to save power consumption. Then aggregate saving would make
> a difference. In addition, penalty of making a wrong decision is cheap.

No, it is _more_ expensive.  With a longer poll interval, the CPU would
never be changed from the slowest speed because the percent idle over that
period would be too high.  More chances to switch speeds out of slowest is
more expensive, not less.

> ...

Carl Thompson


