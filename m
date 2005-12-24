Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVLXQPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVLXQPn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 11:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVLXQPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 11:15:43 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:42430 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932105AbVLXQPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 11:15:43 -0500
Message-ID: <43AD73CF.1050502@gentoo.org>
Date: Sat, 24 Dec 2005 16:14:07 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       venkatesh.pallipadi@intel.com
Subject: Re: [patch 01/19] ACPI: Add support for FADT P_LVL2_UP flag
References: <20051223221200.342826000@press.kroah.org> <20051223224737.GA19057@kroah.com>
In-Reply-To: <20051223224737.GA19057@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> [ACPI] Add support for FADT P_LVL2_UP flag
> which tells us if C2 is valid for UP-only, or SMP.
> 
> As there is no separate bit for C3,  use P_LVL2_UP
> bit to cover both C2 and C3.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=5165
> 

Sorry, we should probably drop this one (and #2) again. The required 3rd 
patch was only recently added to Linus' tree and I didn't get a chance 
to send it to you.

I also have a report that even with the 3rd patch the problem is still 
there:

http://bugs.gentoo.org/show_bug.cgi?id=115781

I'm now wondering if that is related to the option that Pavel just 
pointed out. I'll be sending that bug upstream once we have more details.

Daniel
