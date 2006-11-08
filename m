Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWKHQAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWKHQAc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWKHQAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:00:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:57487 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1030210AbWKHQAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:00:30 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,401,1157353200"; 
   d="scan'208"; a="160127307:sNHT307653199"
Message-ID: <4551FEFD.2060002@intel.com>
Date: Wed, 08 Nov 2006 07:59:57 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Auke Kok <auke-jan.h.kok@intel.com>,
       Pavel Machek <pavel@ucw.cz>, "Robin H. Johnson" <robbat2@gentoo.org>,
       linux-kernel@vger.kernel.org
Subject: Re: e1000/ICH8LAN weirdness - no ethtool link until initially forced
 up
References: <20061106013153.GN15897@curie-int.orbis-terrarum.net> <20061107071449.GB21655@elf.ucw.cz> <4550AB7A.10508@intel.com> <20061107193518.GA26579@thunk.org>
In-Reply-To: <20061107193518.GA26579@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2006 15:59:57.0909 (UTC) FILETIME=[F068F050:01C7034E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Tue, Nov 07, 2006 at 07:51:22AM -0800, Auke Kok wrote:
>> Your application should really `ifconfig up` the device before checking for 
>> link.
> 
> And for those of us with laptops, application authors should do an
> "ifconfig down" the device if it doesn't find a link.  Right now
> thanks to such applications on my desktop, I boot with e1000
> blacklisted so I can run in low-power mode when on a laptop.
> 
> BTW, it would be nice if the e1000 driver could be more safely
> unloaded when it is built as a module.

I'm not aware of unload issues, what is the problem that you have?

Auke
